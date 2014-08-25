import urllib
import requests
import os.path
import json
from penn.registrar import Registrar


def main():
	output = open('coursefile.txt', 'w')
	r = Registrar('UPENN_OD_emud_1000683', '1vkd6m32bo1polkdfup713dmte')
	search_params = r.search_params()
	departments = search_params['departments_map'].keys()
	for dept in departments:
		print dept
		courses_in_dept = r.department(dept)
		for course in courses_in_dept:
			output.write(str(course) + "\n")
	output.close()

def toJSON():
	source = open('coursefile.txt', 'r')
	data = []
	for line in source:
		data.append(line.strip("\n"))
 	with open('courses.json', 'w') as outfile:
		json.dump(data, outfile, sort_keys = True, indent = 4, ensure_ascii = False)


if __name__ == "__main__":
	# main()
	toJSON()