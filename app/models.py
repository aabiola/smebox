from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash

from app import db, login_manager

class Organisation(UserMixin, db.Model):
    """
    Create an Organisation table
    """
    __tablename__ = 'sec_organisation'

    id = db.Column(db.Integer, primary_key=True)
    org_email = db.Column(db.String(60), index=True, unique=True)
    org_phone = db.Column(db.String(60), index=True)
    org_name = db.Column(db.String(60), index=True)
    password_hash = db.Column(db.String(128))
    org_sizeid = db.Column(db.Integer, db.ForeignKey('sec_size.id'))
    org_industryid = db.Column(db.Integer, db.ForeignKey('sec_industry.id'))
    org_status = db.Column(db.Boolean, default=True)
    #relationships
    projects = db.relationship('Project', backref='organisation',
                                lazy='dynamic')


    @property
    def password(self):
        """
        Prevent pasword from being accessed
        """
        raise AttributeError('password is not a readable attribute.')

    @password.setter
    def password(self, password):
        """
        Set password to a hashed password
        """
        self.password_hash = generate_password_hash(password)

    def verify_password(self, password):
        """
        Check if hashed password matches actual password
        """
        return check_password_hash(self.password_hash, password)

    def get_id(self):
        
        return str(self.id)
 

    def __repr__(self):
        return '<Organisation: {}>'.format(self.org_name)


# Set up user_loader
@login_manager.user_loader
def load_user(id):
    return Organisation.query.get(int(id))



class Industry(db.Model):
    """
    Create a Department table
    """

    __tablename__ = 'sec_industry'

    id = db.Column(db.Integer, primary_key=True)
    industry_name = db.Column(db.String(60), unique=True)
    industry_serverip = db.Column(db.String(50))
    industry_core = db.Column(db.Integer, db.ForeignKey('sec_category.id')) # this represents the core activity/task in the industry, links with category table
    
    #relationships
    organisations = db.relationship('Organisation', backref='industry',lazy=True)
    aproject = db.relationship('Project', backref='indust',lazy=True)

    def __repr__(self):
        return '<Industry: {}>'.format(self.industry_name)


# tasks and category start
class Task(db.Model):
    """
    Create an Task table
    """

    __tablename__ = 'sec_task'

    id = db.Column(db.Integer, primary_key=True)
    task_shortname = db.Column(db.String(60), index=True, unique=True)
    task_function = db.Column(db.String(60))
    task_filename = db.Column(db.String(60))
    task_purpose = db.Column(db.String(128))
    task_catid = db.Column(db.Integer, db.ForeignKey('sec_category.id'))
     
    
    def __repr__(self):
        return '<Task: {}>'.format(self.task_name)
#category
class Category(db.Model):
    """
    Create a category table
    """

    __tablename__ = 'sec_category'

    id = db.Column(db.Integer, primary_key=True)
    cat_name = db.Column(db.String(60), unique=True)
   
    #relationships 
    categories = db.relationship('Task', backref='category',lazy='dynamic')
    indus = db.relationship('Industry', backref='cat', lazy=True, uselist=False)

    def __repr__(self):
        return '<category: {}>'.format(self.cat_name)

#size - good for marketing of our customers, has nothing to do with project size/node

class Orgsize(db.Model):
    """
    Create a sec_size table
    """

    __tablename__ = 'sec_size'

    id = db.Column(db.Integer, primary_key=True)
    size_desc = db.Column(db.String(60))

    # some relationships with other tables

    orgs = db.relationship('Organisation', backref='organisation', lazy=True)
   
    def __repr__(self):
        return '<orgsize: {}>'.format(self.size_desc)

#project

class Project(db.Model): # parent
    """
    Create a Project table
    """

    __tablename__ = 'sec_project'

    id = db.Column(db.Integer, primary_key=True)
    project_name = db.Column(db.String(100), index=True)
    project_details = db.Column(db.String(128)) # can be used to store the starting Private IP address of the instance when launched
    project_industryid = db.Column(db.Integer, db.ForeignKey('sec_industry.id'))

    project_datesetup = db.Column(u'project_datesetup', db.TIMESTAMP(timezone=True), nullable=False)
    project_status = db.Column(db.String(128))
    project_orgid = db.Column(db.Integer, db.ForeignKey('sec_organisation.id'))
    

    # other settings
    project_ip = db.Column(db.String(50)) #to allow them specify the IP address of the network
    project_netip = db.Column(db.String(50)) #future use
    project_netos = db.Column(db.String(50))
    project_bandwidth_delay = db.Column(db.Integer)
    project_totalnodes = db.Column(db.Integer)

    #nodes

    project_corenodes = db.Column(db.Integer)
    project_coreos = db.Column(db.String(50))

    project_generalnodes = db.Column(db.Integer)
    project_generalos = db.Column(db.String(50))

    #
    project_extratraffic = db.Column(db.Integer)

    #firewall settings
    project_firewallin = db.Column(db.String(100))
    project_firewallout = db.Column(db.String(100))



    allinstances = db.relationship("ProjectInstance", backref="project", lazy=True)

    def __repr__(self):
        return '<Project: {}>'.format(self.project_name)

 #instances

class ProjectInstance(UserMixin, db.Model): #child
    __tablename__ = 'sec_instances'
    instance_id = db.Column(db.Integer, primary_key=True)
    instance_start = db.Column(db.TIMESTAMP,nullable=False)
    instance_end = db.Column(db.TIMESTAMP)

    #settings generated dynamically for each instance/launch
    instance_iprange = db.Column(db.String(100)) #records the Ip address range used for all the workstations
    instance_ipwebserver = db.Column(db.String(100)) #the Ip address of the webserver (emulating the internet)
    instance_ipelastic = db.Column(db.String(100)) #the Ip address of the elastic search (outside the network)
    instance_ipnetworkadmin = db.Column(db.String(100)) #the Ip address of the network monitoring tools (can be viewed to monitor activities on the network during the launch)
    instance_ipdhcp = db.Column(db.String(100)) #the Ip address of the DHCP/DNS/Firewall server (directly protecting the network, )\
    instance_ipdmz = db.Column(db.String(100)) #the Ip address of the Firewall server sitting in the DMZ 
    instance_ipcore = db.Column(db.String(100)) #the Ip address of the server used in the enterprise for its core operations.

    #relationships
    instance_projectid = db.Column(db.Integer, db.ForeignKey('sec_project.id'),nullable=False)
    #parents = db.relationship("Project", back_populates="children")