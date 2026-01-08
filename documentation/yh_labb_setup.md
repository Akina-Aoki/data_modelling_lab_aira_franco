# Documentation for YH Labb of all  actions in the terminal, code to set up the environment and workflows
[Docker Fundamentals Video](https://www.youtube.com/watch?v=lAckpoLox5g)

## requirements.txt
- The `requirements.txt` file contains the list of Python packages required for the project. To install the dependencies, run the following command in your terminal:

```bash
pip install pandas sqlalchemy psycopg2-binary python-dotenv ipykernel openpyxl matplotlib
```
<br>
- This command will create or update the `requirements.txt` file with the currently installed packages in virtual environment. `yh_labb/requirements.txt` 

```bash
pip freeze > requirements.txt
```

<br>
- Can be updated by running the following command in the terminal:
```bash
pip install -r requirements.txt
```


# THIS IS NOT READT YET. DON'T USE IT YET.
## docker build -t
Name the Docker image `yh-labb-app` by running the following command in the terminal at the root of the `yh_labb` folder:
```bash
docker build -t yh-labb-app .
```
<br>
- Spin up the container locally with the following command:
```bash
docker run --name yh-labb-app yh-labb-app
```

<br>
- To run the Docker container interactively, use the following command:
```bash
docker run -it yh-labb-app
```

```bash
ls
```

```bash
cat `filename
```

