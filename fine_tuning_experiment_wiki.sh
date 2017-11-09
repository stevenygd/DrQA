#! /bin/bash

# WikiMovies

# Preprocessing data
# python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WikiMovies-train.dstrain-squad-like
# python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WikiMovies-train.dsdev-squad-like

for i in "1" "2" "3" "4" "5"; do
    path="models/my_finetune_wikimovies_epo$i"
    if [ ! -d "$path" ]; then
        echo "Path not exists : $path"
        mkdir -p $path/
        echo "Make path $path"
        python scripts/reader/train.py \
            --num-epochs=$i \
            --batch-size=32 \
            --model-dir $path/ \
            --model-name MyFinetuneWikiMovies \
            --data-dir data/datasets/ \
            --train-file WikiMovies-train.dstrain-squad-like-processed-corenlp.txt \
            --dev-file WikiMovies-train.dsdev-squad-like-processed-corenlp.txt \
            --dev-json WikiMovies-train.dsdev-squad-like.json \
            --embedding-file glove.840B.300d.txt \
            --checkpoint True \
            --pretrained data/reader/single.mdl \
            --embedding-file glove.840B.300d.txt \
            --expand-dictionary True \
            --use-ner=False \
            --use-pos=False \
            --use-lemma=False \
            --tune-partial 1000;

        python scripts/pipeline/predict.py data/datasets/WikiMovies-test.txt \
            --reader-model $path/MyFinetuneWikiMovies.mdl \
            --out-dir $path/ \
            --candidate-file data/datasets/WikiMovies-entities.txt \
            --predict-batch-size 500;
    fi;

    python scripts/pipeline/eval.py data/datasets/WikiMovies-test.txt $path/WikiMovies-test-MyFinetuneWikiMovies-pipeline.preds > $path/wikimovies-result-epo$i.log;

    # python scripts/pipeline/predict.py data/datasets/WikiMovies-test.txt --reader-model models/MyFinetuneWikiMovies.mdl --out-dir `pwd` --batch-size=64 --predict-batch-size=64;

    # python scripts/pipeline/eval.py data/datasets/WikiMovies-test.txt WikiMovies-test-MyFinetuneWikiMovies-pipeline.preds;

    cat $path/wikimovies-result-epo$i.log;
done
