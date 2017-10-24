import os
import argparse
import json

DATA_DIR = 'data/datasets'
CURATED_TRAIN = 'CuratedTrec-train.dstrain-squad-like.json'
WEBQUESTION_TRAIN = 'WebQuestions-train.dstrain-squad-like.json'
WIKIMOVIES_TRAIN = 'WikiMovies-train.dstrain-squad-like.json'
SQUAD_TRAIN = 'SQuAD-v1.1-train.json'

curated_data = json.load(open(os.path.join(DATA_DIR, CURATED_TRAIN)))['data']
webquestion_data = json.load(open(os.path.join(DATA_DIR, WEBQUESTION_TRAIN)))['data']
wikimovies_data = json.load(open(os.path.join(DATA_DIR, WIKIMOVIES_TRAIN)))['data']
squad_data = json.load(open(os.path.join(DATA_DIR, SQUAD_TRAIN)))['data']

data =  curated_data * 108 + \
        webquestion_data * 15 + \
        (wikimovies_data * 2)[:int(len(wikimovies_data)*1.16)] + \
        squad_data

out = {
    "data":data, "version" : "1.1"
}

output_file = os.path.join(DATA_DIR, "DistDataAll-train.json")
print("Outputting to :%s"%output_file)
with open(output_file, "w") as out_f:
    json.dump(out, out_f)


