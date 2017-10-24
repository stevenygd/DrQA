import os
import json
import numpy as np

np.random.seed(38383)

DATA_DIR = "data/datasets/"

squad_in_file = os.path.join(DATA_DIR, "SQuAD-v1.1-dev.txt")
squad_out_file = os.path.join(DATA_DIR, "SQuAD-v1.1-dev-sm.txt")

curatedtrec_in_file = os.path.join(DATA_DIR, "CuratedTrec-test.txt")
curatedtrec_out_file = os.path.join(DATA_DIR, "CuratedTrec-test-sm.txt")

webquestion_in_file = os.path.join(DATA_DIR, "WebQuestions-test.txt")
webquestion_out_file = os.path.join(DATA_DIR, "WebQuestions-test-sm.txt")

wikimovies_in_file = os.path.join(DATA_DIR, "WikiMovies-test.txt")
wikimovies_out_file = os.path.join(DATA_DIR, "WikiMovies-test-sm.txt")

for in_fname, out_fname in [
        (squad_in_file, squad_out_file),
        (curatedtrec_in_file, curatedtrec_out_file),
        (webquestion_in_file, webquestion_out_file),
        (wikimovies_in_file,  wikimovies_out_file)
    ]:
    print("InFile:%s\nOutFile:%s"%(in_fname, out_fname))
    with open(in_fname) as in_f:
        data = in_f.readlines()
    idxs = np.random.choice(len(data), int(len(data)*0.1))
    with open(out_fname, "w") as out_f:
        for idx in idxs:
            out_f.write(data[idx])

