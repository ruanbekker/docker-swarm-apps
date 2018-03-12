import os
from flask import Flask, render_template, request
from elasticsearch import Elasticsearch

ES_URL=os.environ['es_host']
ES_PORT=os.environ['es_port']

app = Flask(__name__)
es = Elasticsearch('ES_URL', port=ES_PORT)

@app.route('/')
def home():
    return render_template('search.html')

@app.route('/search/results', methods=['GET', 'POST'])
def search_request():
    search_term = request.form["input"]
    res = es.search(
        index=["scrape-sysadmins", "scrape-octopress"],
        size=20,
        body={
            "query": {
                "multi_match" : {
                    "query": search_term,
                    "fields": [
                        "url",
                        "title",
                        "tags"
                    ]
                }
            }
        }
    )
    return render_template('results.html', res=res )

if __name__ == '__main__':
    app.secret_key = 'mysecret'
    app.run(host='127.0.0.1', port=5000)
