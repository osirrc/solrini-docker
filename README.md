# Prepare

```
python run.py prepare \
  --repo osirrc2019/solrini \
  --collections robust04=/home/ryan/sync/ir/collections/disk45=trectext \
  --opts solr_memory=8G solr_version 7.6.0
```

# Interact

```
python run.py interact --repo osirrc2019/solrini
```

Use `docker ps` to see the container running with a port mapping that looks like `0.0.0.0:[port]->8983/tcp`. Navigate to `0.0.0.0:[port]` in your web browser to view Solr.
