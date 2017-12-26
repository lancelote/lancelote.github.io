update:
	python -m pip install -U pip setuptools
	python -m pip install -r requirements.txt

deps:
	pur -r requirements.txt