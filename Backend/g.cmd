python xml_to_csv.py
python generate_tfrecord.py --csv_input=images\train_labels.csv --image_dir=images\train --output_path=train.record
python generate_tfrecord.py --csv_input=images\test_labels.csv --image_dir=images\test --output_path=test.record
python model_main.py --pipeline_config_path=training/pipeline.config --model_dir=training/ --num_train_steps=50000 --sample_1_of_n_eval_examples=1 --alsologtostderr