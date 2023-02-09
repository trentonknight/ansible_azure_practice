#!/bin/bash

poetry run pip3 install --upgrade pip; \
	poetry run pip3 install --upgrade virtualenv; \
	poetry run ansible-galaxy collection install azure.azcollection; \
	poetry run pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
