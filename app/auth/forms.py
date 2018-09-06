from flask_wtf import FlaskForm
from wtforms import PasswordField, BooleanField, SelectField, StringField, SubmitField, ValidationError
from wtforms.validators import DataRequired, Email, EqualTo

from ..models import Organisation

class RegistrationForm(FlaskForm):
    """
    Form for users to create new account
    """
    coyname = StringField('Company or Individual Name', validators=[DataRequired()], render_kw={"placeholder": "Company or Individual Name"})
    email = StringField('Email', validators=[DataRequired(), Email()], render_kw={"placeholder": "Email"})
    phone = StringField('Phone Number', validators=[DataRequired()],render_kw={"placeholder": "Phone Number"})
    industry = SelectField(u'Industry', choices=[(0,'Please Select'),(1, 'Software Development Company'), (2, 'Surgery'), (3, 'Law Firm')],coerce=int)
    
    pwd = PasswordField('Password',render_kw={"placeholder": "Password"})
    cpass = PasswordField('Confirm Password', validators=[
                                        DataRequired(),
                                        EqualTo('pwd',message='Passwords must match')
                                        ],render_kw={"placeholder": "Password"})
    submit = SubmitField('Register')

    def validate_email(self, field):
        if Organisation.query.filter_by(org_email=field.data).first():
            raise ValidationError('Email is already in use.')

    

class LoginForm(FlaskForm):
    """
    Form for users to login
    """
    email = StringField('Email', validators=[DataRequired(), Email()])
    pwd = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Login')