-- -------------------------------------------------------------
-- TablePlus 3.5.3(314)
--
-- https://tableplus.com/
--
-- Database: example-storefront
-- Generation Time: 2020-05-28 08:40:29.7320
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


CREATE TABLE `shipping_customer_group_price` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shipping_price_id` int(10) unsigned NOT NULL,
  `customer_group_id` int(10) unsigned NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_customer_group_price_shipping_price_id_foreign` (`shipping_price_id`),
  KEY `shipping_customer_group_price_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `shipping_customer_group_price_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`),
  CONSTRAINT `shipping_customer_group_price_shipping_price_id_foreign` FOREIGN KEY (`shipping_price_id`) REFERENCES `shipping_prices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `shipping_method_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int(10) unsigned NOT NULL,
  `shipping_method_id` int(10) unsigned NOT NULL,
  `published_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_method_channel_channel_id_foreign` (`channel_id`),
  KEY `shipping_method_channel_shipping_method_id_foreign` (`shipping_method_id`),
  CONSTRAINT `shipping_method_channel_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`),
  CONSTRAINT `shipping_method_channel_shipping_method_id_foreign` FOREIGN KEY (`shipping_method_id`) REFERENCES `shipping_methods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `shipping_method_zones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shipping_method_id` int(10) unsigned NOT NULL,
  `shipping_zone_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_method_zones_shipping_method_id_foreign` (`shipping_method_id`),
  KEY `shipping_method_zones_shipping_zone_id_foreign` (`shipping_zone_id`),
  CONSTRAINT `shipping_method_zones_shipping_method_id_foreign` FOREIGN KEY (`shipping_method_id`) REFERENCES `shipping_methods` (`id`),
  CONSTRAINT `shipping_method_zones_shipping_zone_id_foreign` FOREIGN KEY (`shipping_zone_id`) REFERENCES `shipping_zones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `shipping_methods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_data` json NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `shipping_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shipping_method_id` int(10) unsigned NOT NULL,
  `shipping_zone_id` int(10) unsigned DEFAULT NULL,
  `rate` int(10) unsigned NOT NULL DEFAULT '0',
  `min_basket` int(10) unsigned NOT NULL DEFAULT '0',
  `currency_id` int(10) unsigned NOT NULL,
  `fixed` tinyint(1) NOT NULL DEFAULT '1',
  `min_weight` decimal(10,5) unsigned NOT NULL DEFAULT '0.00000',
  `weight_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'kg',
  `min_height` decimal(10,5) unsigned NOT NULL DEFAULT '0.00000',
  `height_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cm',
  `min_width` decimal(10,5) unsigned NOT NULL DEFAULT '0.00000',
  `width_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cm',
  `min_depth` decimal(10,5) unsigned NOT NULL DEFAULT '0.00000',
  `depth_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cm',
  `min_volume` decimal(10,5) unsigned NOT NULL DEFAULT '0.00000',
  `volume_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'l',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_prices_shipping_method_id_foreign` (`shipping_method_id`),
  KEY `shipping_prices_currency_id_foreign` (`currency_id`),
  KEY `shipping_prices_shipping_zone_id_foreign` (`shipping_zone_id`),
  CONSTRAINT `shipping_prices_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `shipping_prices_shipping_method_id_foreign` FOREIGN KEY (`shipping_method_id`) REFERENCES `shipping_methods` (`id`),
  CONSTRAINT `shipping_prices_shipping_zone_id_foreign` FOREIGN KEY (`shipping_zone_id`) REFERENCES `shipping_zones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `shipping_regions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(10) unsigned NOT NULL,
  `shipping_zone_id` int(10) unsigned NOT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address_field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_regions_country_id_foreign` (`country_id`),
  KEY `shipping_regions_shipping_zone_id_foreign` (`shipping_zone_id`),
  CONSTRAINT `shipping_regions_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `shipping_regions_shipping_zone_id_foreign` FOREIGN KEY (`shipping_zone_id`) REFERENCES `shipping_zones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=308 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `shipping_zone_country` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(10) unsigned NOT NULL,
  `shipping_zone_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_zone_country_country_id_foreign` (`country_id`),
  KEY `shipping_zone_country_shipping_zone_id_foreign` (`shipping_zone_id`),
  CONSTRAINT `shipping_zone_country_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `shipping_zone_country_shipping_zone_id_foreign` FOREIGN KEY (`shipping_zone_id`) REFERENCES `shipping_zones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `shipping_zones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `regional` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `shipping_zones_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `shipping_customer_group_price` (`id`, `shipping_price_id`, `customer_group_id`, `visible`, `created_at`, `updated_at`) VALUES
('1', '1', '1', '1', NULL, NULL),
('2', '2', '1', '1', NULL, NULL),
('3', '3', '1', '1', NULL, NULL);

INSERT INTO `shipping_method_channel` (`id`, `channel_id`, `shipping_method_id`, `published_at`, `created_at`, `updated_at`) VALUES
('1', '1', '1', '2020-05-26 16:02:32', '2020-05-26 16:02:32', '2020-05-26 16:02:32'),
('2', '1', '2', '2020-05-26 16:02:32', '2020-05-26 16:02:32', '2020-05-26 16:02:32'),
('3', '1', '3', '2020-05-26 16:02:32', '2020-05-26 16:02:32', '2020-05-26 16:02:32');

INSERT INTO `shipping_method_zones` (`id`, `shipping_method_id`, `shipping_zone_id`, `created_at`, `updated_at`) VALUES
('1', '1', '1', NULL, NULL),
('2', '2', '2', NULL, NULL),
('3', '3', '3', NULL, NULL);

INSERT INTO `shipping_methods` (`id`, `attribute_data`, `type`, `created_at`, `updated_at`) VALUES
('1', '{\"name\": {\"webstore\": {\"en\": \"Standard Delivery\"}}, \"description\": {\"webstore\": {\"en\": \"\"}}}', 'regional', '2018-06-25 11:00:04', '2018-06-25 11:00:04'),
('2', '{\"name\": {\"webstore\": {\"en\": \"Europe Delivery\"}}, \"description\": {\"webstore\": {\"en\": \"\"}}}', 'regional', '2018-06-25 11:00:04', '2018-06-25 11:00:04'),
('3', '{\"name\": {\"webstore\": {\"en\": \"US Delivery\"}}, \"description\": {\"webstore\": {\"en\": \"\"}}}', 'regional', '2018-06-25 11:00:04', '2018-06-25 11:00:04');

INSERT INTO `shipping_prices` (`id`, `shipping_method_id`, `shipping_zone_id`, `rate`, `min_basket`, `currency_id`, `fixed`, `min_weight`, `weight_unit`, `min_height`, `height_unit`, `min_width`, `width_unit`, `min_depth`, `depth_unit`, `min_volume`, `volume_unit`, `created_at`, `updated_at`) VALUES
('1', '1', '1', '2500', '0', '1', '1', '0.00000', 'kg', '0.00000', 'cm', '0.00000', 'cm', '0.00000', 'cm', '0.00000', 'l', '2018-06-25 12:00:04', '2018-06-25 12:00:04'),
('2', '2', '2', '4500', '0', '1', '1', '0.00000', 'kg', '0.00000', 'cm', '0.00000', 'cm', '0.00000', 'cm', '0.00000', 'l', '2018-06-25 12:00:04', '2018-06-25 12:00:04'),
('3', '3', '3', '7000', '0', '1', '1', '0.00000', 'kg', '0.00000', 'cm', '0.00000', 'cm', '0.00000', 'cm', '0.00000', 'l', '2018-06-25 12:00:04', '2018-06-25 12:00:04');

INSERT INTO `shipping_regions` (`id`, `country_id`, `shipping_zone_id`, `region`, `address_field`, `created_at`, `updated_at`) VALUES
('1', '79', '1', '*', 'postcode', '2018-06-25 12:00:04', '2018-06-25 12:00:04'),
('2', '75', '2', '*', 'postcode', '2018-06-25 12:00:04', '2018-06-25 12:00:04'),
('3', '234', '3', '*', 'postcode', '2018-06-25 12:00:04', '2018-06-25 12:00:04');

INSERT INTO `shipping_zone_country` (`id`, `country_id`, `shipping_zone_id`, `created_at`, `updated_at`) VALUES
('1', '79', '1', '2020-05-26 15:56:09', '2020-05-26 15:56:09'),
('2', '75', '2', '2020-05-26 15:56:38', '2020-05-26 15:56:38'),
('3', '234', '3', '2020-05-26 15:56:38', '2020-05-26 15:56:38');

INSERT INTO `shipping_zones` (`id`, `name`, `created_at`, `updated_at`, `regional`) VALUES
('1', 'UK Delivery', '2020-05-26 15:54:52', '2020-05-26 15:54:52', '1'),
('2', 'Europe Delivery', '2020-05-26 15:54:52', '2020-05-26 15:54:52', '1'),
('3', 'Worldwide', '2020-05-26 15:54:52', '2020-05-26 15:54:52', '1');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;