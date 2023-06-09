-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema solvd_web_store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema solvd_web_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `solvd_web_store` DEFAULT CHARACTER SET utf8 ;
USE `solvd_web_store` ;

-- -----------------------------------------------------
-- Table `solvd_web_store`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solvd_web_store`.`cart` (
  `id` INT NOT NULL,
  `creation_date` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solvd_web_store`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solvd_web_store`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `registration_date` DATE NOT NULL,
  `cart_id` INT NOT NULL,
  PRIMARY KEY (`id`, `cart_id`),
  INDEX `fk_user_cart1_idx` (`cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_cart1`
    FOREIGN KEY (`cart_id`)
    REFERENCES `solvd_web_store`.`cart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solvd_web_store`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solvd_web_store`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address_line1` VARCHAR(100) NOT NULL,
  `address_line2` VARCHAR(100) NULL,
  `city` VARCHAR(100) NOT NULL,
  `state` VARCHAR(50) NOT NULL,
  `zip_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solvd_web_store`.`user_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solvd_web_store`.`user_address` (
  `user_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `address_id`),
  INDEX `fk_user_has_address_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_user_has_address_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_address_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `solvd_web_store`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_address_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `solvd_web_store`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solvd_web_store`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solvd_web_store`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(300) NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `stock_quantity` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solvd_web_store`.`cart_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solvd_web_store`.`cart_item` (
  `id` INT NOT NULL,
  `quantity` INT NULL,
  `product_id` INT NOT NULL,
  `cart_id` INT NOT NULL,
  PRIMARY KEY (`id`, `product_id`, `cart_id`),
  INDEX `fk_cart_item_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_cart_item_cart1_idx` (`cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_cart_item_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `solvd_web_store`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_item_cart1`
    FOREIGN KEY (`cart_id`)
    REFERENCES `solvd_web_store`.`cart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solvd_web_store`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solvd_web_store`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATE NOT NULL,
  `total_amount` DECIMAL(10,2) NOT NULL,
  `user_id` INT NOT NULL,
  `user_cart_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`, `user_cart_id`),
  INDEX `fk_order_user1_idx` (`user_id` ASC, `user_cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_user1`
    FOREIGN KEY (`user_id` , `user_cart_id`)
    REFERENCES `solvd_web_store`.`user` (`id` , `cart_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solvd_web_store`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solvd_web_store`.`category` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(300) NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`id`, `product_id`),
  INDEX `fk_category_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_category_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `solvd_web_store`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solvd_web_store`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solvd_web_store`.`payment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) NOT NULL,
  `order_id` INT NOT NULL,
  `order_user_id` INT NOT NULL,
  `order_user_cart_id` INT NOT NULL,
  PRIMARY KEY (`id`, `order_id`, `order_user_id`, `order_user_cart_id`),
  INDEX `fk_payment_order1_idx` (`order_id` ASC, `order_user_id` ASC, `order_user_cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_order1`
    FOREIGN KEY (`order_id` , `order_user_id` , `order_user_cart_id`)
    REFERENCES `solvd_web_store`.`order` (`id` , `user_id` , `user_cart_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solvd_web_store`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solvd_web_store`.`review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rating` DECIMAL(2,1) NOT NULL,
  `comment` TEXT NULL,
  `product_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `user_cart_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`, `user_cart_id`),
  INDEX `fk_review_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_review_user1_idx` (`user_id` ASC, `user_cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_review_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `solvd_web_store`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`user_id` , `user_cart_id`)
    REFERENCES `solvd_web_store`.`user` (`id` , `cart_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
