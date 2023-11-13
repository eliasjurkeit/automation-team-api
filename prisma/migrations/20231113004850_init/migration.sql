-- CreateTable
CREATE TABLE `User` (
    `email` VARCHAR(50) NOT NULL,
    `password` VARCHAR(191) NULL,
    `userViewAccess` BOOLEAN NOT NULL,
    `teamViewAccess` BOOLEAN NOT NULL,
    `blogViewAccess` BOOLEAN NOT NULL,
    `projectViewAccess` BOOLEAN NOT NULL,
    `socialsViewAccess` BOOLEAN NOT NULL,
    `featureViewAccess` BOOLEAN NOT NULL,
    `auditTrailViewAccess` BOOLEAN NOT NULL,
    `assetViewAccess` BOOLEAN NOT NULL,
    `jwtTokenId` VARCHAR(191) NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    UNIQUE INDEX `User_jwtTokenId_key`(`jwtTokenId`),
    PRIMARY KEY (`email`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `JwtToken` (
    `id` VARCHAR(191) NOT NULL,
    `token` VARCHAR(512) NOT NULL,
    `aliveInSeconds` INTEGER NOT NULL,

    UNIQUE INDEX `JwtToken_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Activity` (
    `id` VARCHAR(191) NOT NULL,
    `dateTime` DATETIME(3) NOT NULL,
    `issuer` VARCHAR(50) NOT NULL,
    `operation` ENUM('CREATE', 'READ', 'UPDATE', 'DELETE') NOT NULL,
    `affectedRessource` JSON NOT NULL,

    UNIQUE INDEX `Activity_id_key`(`id`),
    UNIQUE INDEX `Activity_issuer_key`(`issuer`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Member` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `firstName` VARCHAR(30) NOT NULL,
    `lastName` VARCHAR(30) NOT NULL,
    `jobTitle` VARCHAR(80) NOT NULL,
    `responsibility` VARCHAR(50) NOT NULL,
    `profilePictureAssetId` VARCHAR(191) NULL,
    `org` VARCHAR(15) NOT NULL,
    `departmentId` VARCHAR(20) NOT NULL,
    `order` INTEGER NOT NULL,

    UNIQUE INDEX `Member_id_key`(`id`),
    UNIQUE INDEX `Member_profilePictureAssetId_key`(`profilePictureAssetId`),
    UNIQUE INDEX `Member_departmentId_key`(`departmentId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Department` (
    `name` VARCHAR(20) NOT NULL,
    `order` INTEGER NOT NULL,

    UNIQUE INDEX `Department_name_key`(`name`),
    PRIMARY KEY (`name`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Blog` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,
    `publicationDate` DATETIME(3) NULL,
    `publicationStatus` ENUM('DRAFT', 'PUBLISHED') NOT NULL,
    `synopsis` MEDIUMTEXT NULL,
    `content` TEXT NULL,
    `order` INTEGER NOT NULL,
    `authorId` INTEGER NULL,
    `thumbnailAssetId` VARCHAR(191) NULL,
    `featuring` BOOLEAN NULL,
    `featureOrder` INTEGER NULL,

    UNIQUE INDEX `Blog_id_key`(`id`),
    UNIQUE INDEX `Blog_authorId_key`(`authorId`),
    UNIQUE INDEX `Blog_thumbnailAssetId_key`(`thumbnailAssetId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Asset` (
    `fileName` VARCHAR(191) NOT NULL,
    `data` BLOB NOT NULL,

    UNIQUE INDEX `Asset_fileName_key`(`fileName`),
    PRIMARY KEY (`fileName`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Social` (
    `name` VARCHAR(191) NOT NULL,
    `value` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Social_name_key`(`name`),
    PRIMARY KEY (`name`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Project` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,
    `synopsis` MEDIUMTEXT NULL,
    `content` TEXT NULL,
    `thumbnailAssetId` VARCHAR(191) NULL,
    `order` INTEGER NOT NULL,
    `publicationStatus` ENUM('DRAFT', 'PUBLISHED') NOT NULL,
    `featuring` BOOLEAN NULL,
    `featureOrder` INTEGER NULL,

    UNIQUE INDEX `Project_id_key`(`id`),
    UNIQUE INDEX `Project_thumbnailAssetId_key`(`thumbnailAssetId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_jwtTokenId_fkey` FOREIGN KEY (`jwtTokenId`) REFERENCES `JwtToken`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Activity` ADD CONSTRAINT `Activity_issuer_fkey` FOREIGN KEY (`issuer`) REFERENCES `User`(`email`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Member` ADD CONSTRAINT `Member_profilePictureAssetId_fkey` FOREIGN KEY (`profilePictureAssetId`) REFERENCES `Asset`(`fileName`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Member` ADD CONSTRAINT `Member_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `Department`(`name`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Blog` ADD CONSTRAINT `Blog_authorId_fkey` FOREIGN KEY (`authorId`) REFERENCES `Member`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Blog` ADD CONSTRAINT `Blog_thumbnailAssetId_fkey` FOREIGN KEY (`thumbnailAssetId`) REFERENCES `Asset`(`fileName`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Project` ADD CONSTRAINT `Project_thumbnailAssetId_fkey` FOREIGN KEY (`thumbnailAssetId`) REFERENCES `Asset`(`fileName`) ON DELETE SET NULL ON UPDATE CASCADE;
