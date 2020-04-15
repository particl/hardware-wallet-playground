FROM buildpack-deps:bullseye
# Start `particld` process with specific datadir folder.
# The particld binary & datadir folder has to be mounted inside.
# Folder structure
# -----------------
# / 
#   particld (binary)
#   /data    (data directory)
EXPOSE 14792
CMD ./particld -datadir=/data