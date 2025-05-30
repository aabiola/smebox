"""empty message

Revision ID: 39b1ddeecec1
Revises: 7f848666fd4f
Create Date: 2018-08-21 04:15:47.270076

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '39b1ddeecec1'
down_revision = '7f848666fd4f'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('sec_task', 'task_function')
    op.drop_column('sec_task', 'task_filename')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('sec_task', sa.Column('task_filename', mysql.VARCHAR(length=60), nullable=True))
    op.add_column('sec_task', sa.Column('task_function', mysql.VARCHAR(length=60), nullable=True))
    # ### end Alembic commands ###
