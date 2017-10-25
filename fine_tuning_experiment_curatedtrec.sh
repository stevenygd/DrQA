#! /bin/bash

# CuratedTrec
# Preprocessing data
# python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split CuratedTrec-train.dstrain-squad-like
# python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split CuratedTrec-train.dsdev-squad-like

for i in `seq 3`; do
    path="models/my_finetune_curatedtrect_epo$i"
    rm -r $path/
    mkdir -p $path/
    echo "Make $path"

    python scripts/reader/train.py \
        --num-epochs=$i\
        --batch-size=32 \
        --model-dir $path/ \
        --model-name MyFinetuneCurated \
        --data-dir data/datasets/ \
        --train-file CuratedTrec-train.dstrain-squad-like-processed-corenlp.txt \
        --dev-file CuratedTrec-train.dsdev-squad-like-processed-corenlp.txt \
        --dev-json CuratedTrec-train.dsdev-squad-like.json \
        --embedding-file glove.840B.300d.txt \
        --checkpoint True \
        --pretrained data/reader/single.mdl \
        --embedding-file glove.840B.300d.txt \
        --expand-dictionary True \
        --use-ner=False \
        --use-pos=False \
        --use-lemma=False \
        --tune-partial 700; # Since there are in total 700 words : )

    python scripts/pipeline/predict.py data/datasets/CuratedTrec-test.txt --reader-model $path/MyFinetuneCurated.mdl --out-dir $path/ --batch-size=64 --predict-batch-size=64

    python scripts/pipeline/eval.py data/datasets/CuratedTrec-test.txt $path/CuratedTrec-test-MyFinetuneCurated-pipeline.preds --regex > $path/curated-test-result-epo$i.log
done


