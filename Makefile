update:
	python -m pip install -U pip setuptools
	python -m pip install -r requirements.txt

deps:
	python -m pip install -U pur
	pur -r requirements.txt