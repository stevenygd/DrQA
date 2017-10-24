#! /bin/bash

# CuratedTrec
# Preprocessing data
# python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split CuratedTrec-train.dstrain-squad-like
# python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split CuratedTrec-train.dsdev-squad-like

# python scripts/reader/train.py \
#     --num-epochs=5 \
#     --batch-size=32 \
#     --model-dir models/ \
#     --model-name MyFinetuneCurated \
#     --data-dir data/datasets/ \
#     --train-file CuratedTrec-train.dstrain-squad-like-processed-corenlp.txt \
#     --dev-file CuratedTrec-train.dsdev-squad-like-processed-corenlp.txt \
#     --dev-json CuratedTrec-train.dsdev-squad-like.json \
#     --embedding-file glove.840B.300d.txt \
#     --checkpoint True \
#     --pretrained data/reader/single.mdl \
#     --embedding-file glove.840B.300d.txt
#     # --tune-partial 1000 \
#     # --expand-dictionary True \
#     # --restrict-vocab False

python scripts/pipeline/predict.py data/datasets/CuratedTrec-test.txt --reader-model models/MyFinetuneCurated.mdl --out-dir `pwd` --batch-size=64 --predict-batch-size=64

python scripts/pipeline/eval.py data/datasets/CuratedTrec-test.txt CuratedTrec-test-MyFinetuneCurated-pipeline.preds
