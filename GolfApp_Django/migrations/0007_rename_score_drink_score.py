# Generated by Django 5.0.4 on 2024-07-27 17:03

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('drinks', '0006_rename_job_drink_score'),
    ]

    operations = [
        migrations.RenameField(
            model_name='drink',
            old_name='Score',
            new_name='score',
        ),
    ]
