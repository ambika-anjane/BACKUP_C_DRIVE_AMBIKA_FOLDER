import json
import os
import logging

from django.conf import settings
from django.core.management.base import BaseCommand

# from dbt.analytics.models import DBTLogs


-- under commands/

class Command(BaseCommand):
    help = 'PYTHON jobs'

    def read_json(self, filename):

        Python_LOG_TARGET = getattr(settings, 'Python_LOG_TARGET')
        file_path = os.path.join(Python_LOG_TARGET, filename)
        data = {}
        with open(file_path, 'r') as state:
            data = json.load(state)
        return data

    def handle(self, *args, **options):
        manifest = self.read_json('manifest.json')
        run_results = self.read_json('run_results.json')

        logging.objects.create(
            manifest=manifest,
            run_results=run_results,
        )
