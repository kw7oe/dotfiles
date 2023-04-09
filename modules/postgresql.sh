function start_postgresql() {
    # Setup: other env variables
    export PGHOST="$PGDATA"
    export PGCONF="""
    # Add Custom Settings
    log_min_messages = warning
    log_min_error_statement = error
    log_min_duration_statement = 100  # ms
    log_connections = on
    log_disconnections = on
    log_duration = on
    #log_line_prefix = '[] '
    log_timezone = 'UTC'
    log_statement = 'all'
    log_directory = 'pg_log'
    log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
    logging_collector = on
    log_min_error_statement = error
    """

    # Setup: DB
    [ ! -d $PGDATA ] \
	    && pg_ctl initdb -o "-U postgres" \
	    && cat "$PGCONF" >> $PGDATA/postgresql.conf

    pg_ctl -o "-k $PGDATA" start
}

function stop_postgresql() {
    pg_ctl -o "-k $PGDATA" stop
}

