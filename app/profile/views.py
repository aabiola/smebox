from flask import render_template, json, request,flash, redirect, url_for
from flask_login import login_required
from flask_login import current_user

from . import profile
from .. import db
from ..models import Project, Industry, ProjectInstance

@profile.route('/')
@profile.route('/dashboard')
@login_required
def dashboard():
    """
    Render the dashboard template on the /dashboard route
    """
    from datetime import date
    from datetime import time
    from datetime import datetime

    if current_user.is_authenticated:
    	loggedin_user = current_user.get_id()
    else:
    	loggedin_user = 0

    someprojects = db.session.query(Project).filter(Project.project_orgid == loggedin_user).order_by(Project.project_datesetup.desc()).limit(5).all()
    return render_template('profile/dashboard.html', title="Dashboard", someprojects=someprojects)

#addproject

@profile.route('/addproject', methods=['POST','GET'])
@login_required
def addproject():
	if current_user.is_authenticated:
		loggedin_user = current_user.get_id() # return username in get_id() 
	else:
		loggedin_user = 0
	
	projectname = request.form['projectname']
	projdetails = request.form['projdetails']
	projindustry = request.form['projindustry']
	#nodes = request.form['nodes']
	bandwidth = request.form['bandwidth']
	corenode = request.form['corenode']
	coreos = request.form['coreos']
	generalnode = request.form['generalnode']
	generalos = request.form['generalos']
	
	if "extra" in request.form:
		extra = request.form['extra']
	else:
		extra = 0

	if "outsider" in request.form:
		outsider = request.form['outsider']
	else:
		outsider = 0

	if "insider" in request.form:
		insider = request.form['insider']
	else:
		insider = 0
	
	if "netplans" in request.form:
		networkadminos = request.form['networkadminos']
	else:
		networkadminos = 0
		
 
	project = Project(project_name=projectname, project_details=projdetails, project_industryid=projindustry,
		project_status='active',project_orgid=loggedin_user, project_netos  =networkadminos,
		project_bandwidth_delay=bandwidth,project_corenodes =corenode,
		project_coreos =coreos, project_generalnodes=generalnode,project_generalos =generalos,
		project_extratraffic =extra,insider_threat =insider,outsider_threat =outsider)
	
	
	#db.session.commit()

	conclusion = {'name':projectname,'status':1,'msg':"already set in flash"}
	flash('You have successfully created the Experiment, you can launch it at anytime from here.')

	try:
		db.session.add(project)
		db.session.commit()
		
		#return redirect(url_for('profile.projectlisting'))
	except Exception as e:
		db.session.rollback()
		db.session.flush() 
		conclusion = {'name':projectname,'status':0,'msg':"Error Creating Experiment"}
	finally:
		db.session.close()
	
	return (json.dumps(conclusion))


   
@profile.route('/projects') 
@login_required
def projectlisting():

    """
    Render the 
    """
    if current_user.is_authenticated:
        loggedin_user = current_user.get_id()
    else:
        loggedin_user = 0
    
   
    allprojects = db.session.query(Project, Industry.industry_name).join(Industry).filter(Project.project_orgid == loggedin_user).all()

    return render_template('profile/project.html', title="All Projects", active='active', myprojects=allprojects)



@profile.route('/launch/<int:id>', methods=['GET'])
@login_required
def launch_project(id):
	import fxn
	import time
	from flask import Flask, jsonify

	if current_user.is_authenticated:
		loggedin_user = current_user.get_id()
	else:
		loggedin_user = 0

	#Default message

	msgstr = "Please wait while your machines are being set up "

    # MEMO: This is the part that connects to the Libvirt API (using fxn.py) to start the machines
    # TODO: Connect to KVM, start the network and get the relevant IP addresses for this instance
	# DONE: After the machines all start; Insert an instance and insert the start time, update server config and any other thing worth storing about the instance

	templatedeets = db.session.query(Project.project_name, Project.project_netos, Project.project_corenodes,Project.project_coreos, Project.project_generalnodes, Project.project_generalos, Project.project_extratraffic, Project.insider_threat,Project.outsider_threat,Industry.industry_serverip).join(Industry).filter(Project.project_orgid == loggedin_user).filter(Project.id == id).first()


	#variable with the project
	projectid = id

    # How many corenodes? Which OS?
	# How many general nodes? Which OS?
	# fetch information from db to usde to start the machines

	corenodes = templatedeets.project_corenodes
	coreos = templatedeets.project_coreos
	generalnodes = templatedeets.project_generalnodes
	generalos = templatedeets.project_generalos


	templatename = templatedeets.industry_serverip
	projectname = templatedeets.project_name
	

	netadminos = templatedeets.project_netos
	

	extra = templatedeets.project_extratraffic
	insider = templatedeets.insider_threat
	outsider = templatedeets.outsider_threat

    #contstants for the lab setup, servers with fixed IP

	#External (get these from the Database or a config file since they are constant)
	webserverip = '131.250.250.3' #internex
	elasticip = '192.168.150.2'
	networkadminip = '192.168.100.9'
	
    #Internal Servers with Fixed IP
	dhcp = '192.168.100.2' #nsserver

    #Internal server
	coreop = templatename + ".smebox.net"

    # #internal workstation range as set up and received from KVM
	
	workstations = "4-19" #this is an example generated IP for an SME with 15 workstations, Ip address starts from 4 after the coreop 192.168.0.4-19, Dummy values,not used for now.

	domain = 1 #fxn.topostart(templatename,netadminos)

	time.sleep(10)

	if corenodes:
		core_workstations = 1 #fxn.core_workstation_start(templatename,corenodes,coreos)

	time.sleep(10)
	if generalnodes:
		general_workstations = 1# fxn.general_workstation_start(generalnodes,generalos)

	#time.sleep(360)

	#domain = 1
	if domain:

		#start the  workstations and malicious users

	#insert into db (instance table)
		myinstance = ProjectInstance(instance_projectid =projectid)

		db.session.add(myinstance)
		db.session.commit()

		instanceid = myinstance.instance_id

		myinstid = str(instanceid)

		msgstr = "Please wait while your machines are being set up for the experiment <b>" + projectname + "</b> ...<br><br>"

		#return jsonify({'text':msgstr, 'id': myinstid})
	else:
		msgstr = "Oops, we could not launch the experiment: <b>" + projectname + "</b>, at this time as the machines didn't start. Please try again"
		myinstid = 0
		#return jsonify({'text': msgstr, 'id': 0})
		#TODO shut down any machine that might have started

	return jsonify({'text':msgstr, 'id': myinstid})
	

##Displays the ongoing instance and its parameters
@profile.route('/instances/<int:id>', methods=['GET', 'POST'])
@login_required
def instance_report(id):
	from datetime import date
	from datetime import time
	from datetime import datetime
	#TODO: 
	#fetch from tables - project, instance, industry and display the iteneries of this instance

	
	if current_user.is_authenticated:
		loggedin_user = current_user.get_id()
	else:
		loggedin_user = 0

	
	instance_deets = db.session.query(ProjectInstance, Project, Industry).join(Project).join(Industry).filter(Project.project_orgid == loggedin_user).filter(ProjectInstance.instance_id == id).first()


	return render_template('profile/visual.html', title="Details of Instance", deets=instance_deets)
	

##If project starts but there are some errors due to inability of some machines to start. Degrade gracefully by showing an error page
@profile.route('/error')
@login_required
def error_report():
	from datetime import date
	from datetime import time
	from datetime import datetime
	#TODO: 
	#fetch from tables - project, instance, industry and display the iteneries of this instance

	
	if current_user.is_authenticated:
		loggedin_user = current_user.get_id()
	else:
		loggedin_user = 0

	return render_template('profile/errorpage.html', title="Not All Machines Launched")

@profile.route('/instance/stop/<int:id>', methods=['GET', 'POST'])
@login_required
def stop_instance(id):
	import fxn
	"""This sends signal to the KVM and shut it down. It also updates the end time in the instance table"""
	from datetime import date
	from datetime import time
	from datetime import datetime
	

	if current_user.is_authenticated:
		loggedin_user = current_user.get_id()
	else:
		loggedin_user = 0

	templateId = 1

	stop_status = 1 #fxn.topostop(templateId)
	#loggedin_user - to ensure that users can only operate on the projects they created
	#Send Signal to KVM...
	if stop_status:
		thisInstance = ProjectInstance.query.get(id)
		thisInstance.instance_end = datetime.now()

		db.session.commit()

	return redirect(url_for('profile.projectlisting'))


@profile.route('/report')
@login_required
def report():
    """
    Render the report template on the /report route
    """
    from datetime import date
    from datetime import time
    from datetime import datetime

    if current_user.is_authenticated:
    	loggedin_user = current_user.get_id()
    else:
    	loggedin_user = 0

    someprojects = db.session.query(Project).filter(Project.project_orgid == loggedin_user).order_by(Project.project_datesetup.desc()).limit(5).all()
    return render_template('profile/tab.html', title="Dashboard", someprojects=someprojects)

####################The codes below here are for testing various parts ######################################
@profile.route('/demo/<int:id>', methods=['GET'])
@login_required
def demo(id):
	import fxn

	if current_user.is_authenticated:
		loggedin_user = current_user.get_id()
	else:
		loggedin_user = 0

	#TODO: 
	#Connect to KVM, start the network and get the relevant IP addresses for this instance
	#Insert an instance and insert the start time, update server config and any other thing worth storing about the instance
	#templatedeets = db.session.query(Project.project_name, Project.project_netos, Project.project_corenodes,Project.project_coreos, Project.project_generalnodes, Project.project_generalos, Project.project_extratraffic, Project.project_firewallin, Project.project_firewallout,Industry.industry_serverip).join(Industry).filter(Project.project_orgid == loggedin_user).filter(Project.id == id).first()

	#variable with the project
	# projectid = id
	# templatename = templatedeets.industry_serverip
	# projectname = templatedeets.project_name
	# netadminos = templatedeets.project_netos
	# corenodes = templatedeets.project_corenodes
	# coreos = templatedeets.project_coreos
	# generalnodes = templatedeets.project_generalnodes
	# generalos = templatedeets.project_generalos
	# extra = templatedeets.project_extratraffic
	# firewallin = templatedeets.project_firewallin
	# firewallout = templatedeets.project_firewallout

	#contstants for the lab setup, servers with fixed IP

	#External
	# webserverip = '192.168.250.2' #internex
	# elasticip = '192.168.150.2'
	# networkadminip = '192.168.100.9'
	
	# #Internal Servers with Fixed IP
	# dmz = '192.168.100.8'
	# dhcp = '192.168.100.3' #nsserver

	# #Internal server
	# coreop = templatename + ".smebox.net"

	# # #internal workstation range as set up and received from KVM
	# workstations = "4-19" #this is an example generated IP for an SME with 15 workstations, Ip address starts from 4 after the coreop 192.168.0.4-19

	# #domain = fxn.topostart(templatename,netadminos,extra);
	# if domain:

	# #insert into db (instance table)
	#  	myinstance = ProjectInstance(instance_iprange=workstations, instance_ipwebserver=webserverip,
	#  		instance_ipelastic=elasticip,instance_ipnetworkadmin=networkadminip, instance_ipdhcp =dhcp,
	#  		instance_ipdmz=dmz,instance_ipcore =coreop,instance_projectid =projectid)

	#  	db.session.add(myinstance)
	#  	db.session.commit()
			
	#  	instanceid = myinstance.instance_id

	#  	myinstid = str(instanceid)

	#  	return redirect(url_for('profile.instance_report',id=myinstid))
	# else:
	#  	msg = {'messag':"MAchines were not launched"}
	#  	#return render_template('profile/tab.html', title="Dashboard") projectlisting
	#  	return (json.dumps(domain))
	return redirect(url_for('profile.instance_report',id=10))