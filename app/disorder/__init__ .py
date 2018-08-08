from flask import Blueprint

disorder = Blueprint('disorder', __name__)
from . import views