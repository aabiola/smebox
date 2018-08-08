from flask import flash, redirect, render_template, url_for
from flask_login import login_required, login_user, logout_user

from . import auth
from . forms import LoginForm, RegistrationForm
from .. import db
from ..models import Organisation

@auth.route('/', methods=['GET', 'POST'])
def register():
    """
    Handle requests to the /register route
    Add an organisation to the database through the registration form
    """
    form = RegistrationForm()
    if form.validate_on_submit():
        organisation = Organisation(org_email=form.email.data,
                            org_name=form.cuyname.data,
                            org_phone=form.phone.data,
                            org_industryid=form.industry.data,
                            org_password=form.password.data)

        # add an organisation to the database
        db.session.add(organisation)
        db.session.commit()
        flash('You have successfully registered! You may now login.')

        # redirect to the login page
        return redirect(url_for('auth.login'))

    # load registration template
    return render_template('auth/index.html', form=form, title='Register')

@auth.route('/login', methods=['GET', 'POST'])
def login():
    """
    Handle requests to the /login route
    Log an organisation in through the login form
    """
    form = LoginForm()
    if form.validate_on_submit():

        # check whether organisation exists in the database and whether
        # the password entered matches the password in the database
        organisation = Organisation.query.filter_by(email=form.email.data).first()
        if organisation is not None and organisation.verify_password(
                form.password.data):
            # log organisation in
            login_user(organisation)

            # redirect to the dashboard page after login
            return redirect(url_for('auth.dashboard'))

        # when login details are incorrect
        else:
            flash('Invalid email or password.')

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
    return redirect(url_for('auth.login'))


@auth.route('/dashboard')
@login_required
def dashboard():
    """
    Render the dashboard template on the /dashboard route
    """
    return render_template('profile/dashboard.html', title="Dashboard")