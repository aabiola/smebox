from flask import flash, redirect, render_template, url_for
from flask_login import login_required, login_user, logout_user

#setting my own session
from flask import session
from . import auth
from . forms import LoginForm, RegistrationForm
from .. import db
from ..models import Organisation


@auth.route('/')
def homepage():
    """
    Render the homepage template on the / route
    """
    form = RegistrationForm()

    return render_template('auth/index.html', form=form, title='SME-in-a-BOX Home Page')


@auth.route('/register', methods=['POST'])
def register():
    """
    Handle requests to the / route
    Add an organisation to the database through the registration form
    """
    form = RegistrationForm()
    if form.validate_on_submit():
        organisation = Organisation(org_name=form.coyname.data,
                            org_email=form.email.data,
                            org_phone=form.phone.data,
                            org_industryid=form.industry.data,
                            password=form.pwd.data)

        # add employee to the database
        db.session.add(organisation)
        db.session.commit()
        flash('You have successfully registered! You may now login.')

            # redirect to the login page
        return redirect(url_for('auth.login'))
       

    # load index page template
    #print (form.errors.items())
    #return "Got here"
    return render_template('auth/index.html', form=form, title='SME-in-a-BOX Home Page')

@auth.route('/login', methods=['GET', 'POST'])
def login():
    """
    Handle requests to the /login route
    Log an org in through the login form
    """
    form = LoginForm()
    if form.validate_on_submit():

        organisation = Organisation.query.filter_by(org_email=form.email.data).first()
        if organisation is not None and organisation.verify_password(form.pwd.data):
            
            login_user(organisation)

            
            # redirect to the dashboard page after login
            return redirect(url_for('profile.dashboard'))

        # when login details are incorrect
        else:
            flash("Invalid Username and or Password")

    # load login template
    return render_template('auth/login.html', form=form, title='Login')


@auth.route('/logout')
@login_required
def logout():
    """
    Handle requests to the /logout route
    Log an employee out through the logout link
    """
    logout_user()
    flash('You have successfully been logged out.')

    # redirect to the login page
    #stop all instances running for this person
    return redirect(url_for('auth.login'))