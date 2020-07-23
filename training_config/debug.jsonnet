local template = import "template.libsonnet";

template.DyGIE {
  bert_model: "allenai/scibert_scivocab_cased",
  cuda_device: 0,
  data_paths: {
    train: "data/scierc/processed_data/json/train.json",
    validation: "data/scierc/processed_data/json/dev.json",
    test: "data/scierc/processed_data/json/test.json",
  },
  loss_weights: {
    ner: 1.0,
    relation: 1.0,
    coref: 1.0,
    events: 0.0
  },
  model +: {
    feedforward_params: {
      num_layers: 1,
      hidden_dims: 20,
      dropout: 0.4,
    },
    embedder: {
      token_embedders: {
        tokens: {
          type: "embedding",
          embedding_dim: 100,
        }
      }
    },
    modules +: {
      coref +: {
        coref_prop: 1
      }
    }
  },
  target_task: "relation",
  dataset_reader +: {
    token_indexers: {
      tokens: {
        type: "single_id"
      }
    }
  }
}
