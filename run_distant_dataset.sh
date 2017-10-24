#! /bin/bash

python scripts/convert/to_squad.py data/datasets/CuratedTrec-train.dstrain --out-dir `pwd`
python scripts/reader/predict.py CuratedTrec-train.dstrain-squad-like.json --model=data/reader/multitask.mdl
mv /tmp/CuratedTrec-train.dstrain-squad-like-multitask.preds .
python scripts/reader/official_eval.py CuratedTrec-train.dstrain-squad-like.json CuratedTrec-train.dstrain-squad-like-multitask.preds

