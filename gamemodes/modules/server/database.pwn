/*==============================================================================

                                Database module

==============================================================================*/

#define MYSQL_HOST "localhost"
#define MYSQL_USER "root"
#define MYSQL_PASSWORD ""
#define MYSQL_DATABASE "vrp"

MySqlStartConnection()
{
    new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true);
	mysql_set_option(option_id, POOL_SIZE, 10);
    
    g_iHandle = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id);

    mysql_log(ERROR | WARNING);
 
    if(g_iHandle == MYSQL_INVALID_HANDLE || mysql_errno(g_iHandle) != 0) {
        SendRconCommand("password lk&iu&sds7*)");
        SendRconCommand("hostname Occurred error connection to database ...");
 
        printf("[Database] Connection to \"%s\" failed!", MYSQL_DATABASE);
    }
    else printf("[Database] Connection to \"%s\" passed!", MYSQL_DATABASE);
    return 1;
}

MySqlCloseConnection()
{
    mysql_close(g_iHandle);
    return 1;
}
