{
        "listen": "$TINODE_BIND_SOCKET",
        "api_path": "$TINODE_API_PATH",
        "cache_control": $TINODE_CACHE_CONTROL,
        "static_mount": "$TINODE_STATIC_MOUNT",
        "grpc_listen": "$TINODE_BIND_GRPC_SOCKET",
        "grpc_keepalive_enabled": $TINODE_GRPC_KEEPALIVE_ENABLED,
        "api_key_salt": "$TINODE_API_KEY_SALT",
        "max_message_size": $TINODE_MAX_MESSAGE_SIZE,
        "max_subscriber_count": $TINODE_MAX_SUBSCRIBER_COUNT,
        "max_tag_count": $TINODE_MAX_TAG_COUNT,
        "expvar": "$TINODE_EXPVAR",
        "server_status": "$TINODE_SERVER_STATUS",
        "use_x_forwarded_for": $TINODE_USE_X_FORWARDED_FOR,
        "default_country_code": "$TINODE_COUNTRY_CODE",

	"media": {
		"use_handler": "fs",
		"max_size": 33554432,
		"gc_period": 60,
		"gc_block_size": 100,
		"handlers": {
			"fs": {
				"upload_dir": "uploads"
			},
			"s3":{
				"access_key_id": "",
				"secret_access_key": "",
				"region": "",
				"bucket": "",
				"cors_origin": ""
			}
		}
	},

	"tls": {
		"enabled": $TINODE_TLS_ENABLED,
		"http_redirect": "$TINODE_TLS_HTTP_REDIRECT",
		"strict_max_age": 604800,
		"autocert": {
			"cache": "/etc/letsencrypt/live/$TINODE_TLS_DOMAIN_NAME",
			"email": "$TINODE_TLS_CONTACT_ADDRESS",
			"domains": ["$TINODE_TLS_DOMAIN_NAME"]
		},
		"cert_file": "$TINODE_TLS_CERT_FILE",
		"key_file": "$TINODE_TLS_KEY_FILE"
	},

	"auth_config": {
		"logical_names": [],
		"basic": {
			"add_to_tags": $TINODE_BASIC_AUTH_ADD_TO_TAGS,
			"min_login_length": $TINODE_BASIC_AUTH_MIN_LOGIN_LENGTH,
			"min_password_length": $TINODE_BASIC_AUTH_MIN_PASSWORD_LENGTH
		},
		"token": {
			"expire_in": $TINODE_TOKEN_AUTH_EXPIRE_IN,
			"serial_num": $TINODE_TOKEN_AUTH_SERIAL_NUM,
			"key": "$TINODE_TOKEN_AUTH_KEY"
		}
	},

	"store_config": {
		"uid_key": "la6YsO+bNX/+XIkOqc5Svw==",
		"max_results": 1024,
		"use_adapter": "$TINODE_USE_ADAPTER",

		"adapters": {
			"mysql": {
				"User": "root",
				"Net": "tcp",
				"Addr": "localhost",
				"DBName": "tinode",
				"Collation": "utf8mb4_unicode_ci",
				"ParseTime": true,

				"dsn": "root@tcp(localhost)/tinode?parseTime=true&collation=utf8mb4_unicode_ci",
				"database": "tinode",
				"max_open_conns": 64,
				"max_idle_conns": 64,
				"conn_max_lifetime": 60,
				"sql_timeout": 10
			},

			"rethinkdb": {
				"addresses": "localhost:28015",
				"database": "tinode"
			},

			"mongodb": {
				"uri": "$TINODE_MONGODB_URI",
				"api_version": "1",
				"addresses": $TINODE_MONGODB_ADDRESSES,
				"database": "$TINODE_MONGODB_DATABASE",
				"replica_set": "$TINODE_MONGODB_REPLICA_SET",
				"auth_mechanism": "$TINODE_MONGODB_AUTH_MECHANISM",
				"auth_source": "$TINODE_MONGODB_AUTH_SOURCE",
                "username": "$TINODE_MONGODB_USERNAME",
				"password": "$TINODE_MONGODB_PASSWORD",
				"tls": $TINODE_MONGODB_TLS,
				"tls_cert_file": "$TINODE_MONGODB_TLS_CERT_FILE",
				"tls_private_key": "$TINODE_MONGODB_TLS_PRIVATE_KEY",
				"tls_skip_verify": $TINODE_MONGODB_TLS_SKIP_VERIFY
			}
		}
	},

	"acc_validation": {

		"email": {
			"add_to_tags": true,
			"required": ["$TINODE_EMAIL_VALIDATION"],

			"config": {
				"host_url": "$TINODE_SMTP_HOST_URL",
				"smtp_server": "$TINODE_SMTP_SERVER",
				"smtp_port": "$TINODE_SMTP_PORT",
				"sender": "$TINODE_SMTP_SENDER",
				"login": "$TINODE_SMTP_LOGIN",
				"sender_password": "$TINODE_SMTP_SENDER_PASSWORD",
				"auth_mechanism": "$TINODE_SMTP_AUTH_MECHANISM",
				"smtp_helo_host": "",
				"insecure_skip_verify": $TINODE_SMTP_INSECURE_SKIP_VERIFY,
				"languages": [$TINODE_SMTP_LANGUAGES],
				"validation_templ": "./templ/email-validation-{{.Language}}.templ",
				"reset_secret_templ": "./templ/email-password-reset-{{.Language}}.templ",
				"max_retries": $TINODE_SMTP_MAX_RETRIES,
				"domains": ["$TINODE_SMTP_DOMAINS"],
				"debug_response": "$TINODE_SMTP_DEBUG_RESPONSE"
			}
		},

		"tel": {
			"add_to_tags": true,
			"config": {
				"languages": ["en", "ru"],
				"template": "./templ/sms-validation.templ",
				"max_retries": 4,
				"debug_response": "123456"
			}
		}
	},

	"push": [
		{
            "name":"stdout",
            "config": {
                    "enabled": false
            }
		},
		{
			"name":"fcm",
			"config": {
				"enabled": false,
				"project_id": "your-project-id",
				"credentials": {
					"type": "service_account",
						"project_id": "your-project-id",
						"private_key_id": "some-random-looking-hex-number",
						"private_key": "-----BEGIN PRIVATE KEY----- base64-encoded bits of your private key \n-----END PRIVATE KEY-----\n",
						"client_email": "firebase-adminsdk-abc123@your-project-id.iam.gserviceaccount.com",
						"client_id": "1234567890123456789",
						"auth_uri": "https://accounts.google.com/o/oauth2/auth",
						"token_uri": "https://oauth2.googleapis.com/token",
						"auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
						"client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-abc123%40your-project-id.iam.gserviceaccount.com"
				},

				"credentials_file": "/path/to/service-account-file-with-credentials.json",
				"time_to_live": 3600,

				"android": {
					"enabled": false,
					"icon": "ic_logo_push",
					"color": "#3949AB",
					"click_action": ".MessageActivity",
					"msg": {
						"title": "",
						"body": "",
						"title_loc_key": "new_message",
						"body_loc_key": ""
					},

					"sub": {
						"title_loc_key": "new_chat",
						"body_loc_key": ""
					}
				}
			}
		},
		{
			"name":"tnpg",
			"config": {
				"enabled": false,
				"org": "test",
				"token": "jwt-security-token-obtained-from-console.tinode.co",
			}
		}
	],

	"webrtc": {
		"enabled": false,
		"call_establishment_timeout": 30,
		"ice_servers": [
			{
				"urls": [
					"stun:stun.example.com"
				]
			},
			{
				"username": "user-name-to-use-for-authentication-with-the-server",
				"credential": "your-password",
				"urls": [
					"turn:turn.example.com:80?transport=udp",
					"turn:turn.example.com:3478?transport=udp",
					"turn:turn.example.com:80?transport=tcp",
					"turn:turn.example.com:3478?transport=tcp",
					"turns:turn.example.com:443?transport=tcp",
					"turns:turn.example.com:5349?transport=tcp"
				]
			}
		],
		"ice_servers_file": "/path/to/ice-servers-config.json",
	},

	"cluster_config": {
		"self": "",

		"nodes": [
			{"name": "one", "addr":"localhost:12001"},
			{"name": "two", "addr":"localhost:12002"},
			{"name": "three", "addr":"localhost:12003"}
		],

		"failover": {
			"enabled": true,
			"heartbeat": 100,
			"vote_after": 8,
			"node_fail_after": 16
		}
	},

	"plugins": [
		{
			"enabled": false,
			"name": "python_chat_bot",
			"timeout": 20000,
			"filters": {
				"account": "C"
			},

			"failure_code": 0,
			"failure_text": null,
			"service_addr": "tcp://localhost:40051"
		}
	]
}