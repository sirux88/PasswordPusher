# pwpush-postgres

# Using universal image as a base for old non universal image
# this is for the transition phase since these old image will become obsolete
# using the local 'pwpush' tag is on purpose. 
# Otherwise occationally a wrong version may be pulled from the repository
FROM pwpush

# Setting database backend
ENV DATABASE_URL=postgres://passwordpusher_user:passwordpusher_passwd@postgres:5432/passwordpusher_db