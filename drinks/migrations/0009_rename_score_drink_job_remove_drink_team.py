# Generated by Django 5.0.4 on 2024-10-15 18:31

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('drinks', '0008_drink_team'),
    ]

    operations = [
        migrations.RenameField(
            model_name='drink',
            old_name='score',
            new_name='job',
        ),
        migrations.RemoveField(
            model_name='drink',
            name='team',
        ),
    ]
