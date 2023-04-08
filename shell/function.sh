function start_postgresql() {
    # Setup: other env variables
    export PGHOST="$PGDATA"

    # Setup: DB
    [ ! -d $PGDATA ] \
	    && pg_ctl initdb -o "-U postgres" \
	    && cat "$PGCONF" >> $PGDATA/postgresql.conf

    pg_ctl -o "-k $PGDATA" start
}

function stop_postgresql() {
    pg_ctl -o "-k $PGDATA" stop
}

