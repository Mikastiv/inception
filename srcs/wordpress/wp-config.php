<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('MYSQL_DATABASE') );

/** Database username */
define( 'DB_USER', getenv('MYSQL_USER') );

/** Database password */
define( 'DB_PASSWORD', getenv('MYSQL_PASSWORD') );

/** Database hostname */
define( 'DB_HOST', getenv('MYSQL_SERVER').':3306' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          'FVvX),dZIZ}n8KF:70S ,baPS=hy$+sZ_pLeu?9-UNdA5^skCjH*yR3Zf.&Y=Q[J' );
define( 'SECURE_AUTH_KEY',   'BkGBK7?c4Mh6#,eI_3%FKDjE:{O-LrhRtAlhmJ^,F$yZ8&XLBuftl{G:S)2fl qF' );
define( 'LOGGED_IN_KEY',     'rFOox!X%@aB4i2Vib/]toA.ct)Uo(iCki1eAG$F~RB2a/3C;@[esi&, PEI_nT~H' );
define( 'NONCE_KEY',         ':iQL~L>3,Yc*2-}A<N_xm(juN1Zx|wqWfa]r`@`oxdjGx]eO2(1$.V&VwOD#k~08' );
define( 'AUTH_SALT',         'uZ)>;dMj5#vF3|Ir&=mBAT:/#1g3=@{C9!*9cc=5$Tz/+sfAW:1X1hTM%Jrc8U}w' );
define( 'SECURE_AUTH_SALT',  'fn#&z ;2/6~H;Iu -|J@Z05v=@L +P?Th[%tq Tt@^Sntgip&Yr(!Ro_~/@$2$l*' );
define( 'LOGGED_IN_SALT',    '!7}if1V*8Bbn+|*~A_ gFxIgd,*ukBh8EK-SmeDm`.=#)<JhS%X<jxWWCUSj}oHm' );
define( 'NONCE_SALT',        '/28yIz5Kpw<ZP{WMQsfwe,240.M+4j@?y:J=jBW[`$d/g&5k_yLS=j~y#G[F@iGp' );
define( 'WP_CACHE_KEY_SALT', 'p1bmI4RipWHyjM;t7pRU`^Re5eU-$<_D%roG2TJ8PW#5%+c4/XDO`N(SO$K^P]Vx' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );


/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
