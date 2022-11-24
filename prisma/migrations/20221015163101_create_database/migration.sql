-- CreateEnum
CREATE TYPE "ProductUnit" AS ENUM ('UN', 'KG');

-- CreateEnum
CREATE TYPE "PayOption" AS ENUM ('MBWAY', 'DINHEIRO');

-- CreateEnum
CREATE TYPE "TypeService" AS ENUM ('PAYCHECK', 'HELP');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "username" TEXT NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" TEXT NOT NULL,
    "bar_code" TEXT,
    "name" TEXT NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "cost" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "unit" "ProductUnit" NOT NULL DEFAULT 'UN',
    "description" TEXT DEFAULT '',
    "image" TEXT DEFAULT '',
    "validate_stock" BOOLEAN NOT NULL DEFAULT false,
    "use_card" BOOLEAN NOT NULL DEFAULT false,
    "special_card" BOOLEAN NOT NULL DEFAULT false,
    "categoryId" TEXT,
    "create_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "orderId" TEXT,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categories" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "image" TEXT,
    "option_id" TEXT,
    "extra_id" TEXT,
    "is_card" BOOLEAN NOT NULL DEFAULT false,
    "create_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock_products" (
    "id" TEXT NOT NULL,
    "create_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "productId" TEXT,
    "stockId" TEXT,

    CONSTRAINT "stock_products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock" (
    "id" TEXT NOT NULL,
    "quant" DECIMAL(65,30) NOT NULL,
    "create_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stock_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "options" (
    "id" TEXT NOT NULL,
    "option" TEXT NOT NULL,
    "create_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "options_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "extras" (
    "id" TEXT NOT NULL,
    "option" TEXT NOT NULL,
    "create_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "extras_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders" (
    "id" TEXT NOT NULL,
    "client" TEXT NOT NULL,
    "nif" TEXT,
    "table" TEXT NOT NULL,
    "paymethod" "PayOption" NOT NULL DEFAULT 'DINHEIRO',
    "total_pay" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "status_payment" BOOLEAN NOT NULL DEFAULT false,
    "create_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "call_services" (
    "id" TEXT NOT NULL,
    "client" TEXT NOT NULL,
    "table" TEXT NOT NULL,
    "service" "TypeService" NOT NULL,
    "is_done" BOOLEAN NOT NULL DEFAULT false,
    "create_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "call_services_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_CategoryToOption" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_CategoryToExtra" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_OrderToProduct" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "products_bar_code_key" ON "products"("bar_code");

-- CreateIndex
CREATE UNIQUE INDEX "categories_name_key" ON "categories"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_CategoryToOption_AB_unique" ON "_CategoryToOption"("A", "B");

-- CreateIndex
CREATE INDEX "_CategoryToOption_B_index" ON "_CategoryToOption"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CategoryToExtra_AB_unique" ON "_CategoryToExtra"("A", "B");

-- CreateIndex
CREATE INDEX "_CategoryToExtra_B_index" ON "_CategoryToExtra"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_OrderToProduct_AB_unique" ON "_OrderToProduct"("A", "B");

-- CreateIndex
CREATE INDEX "_OrderToProduct_B_index" ON "_OrderToProduct"("B");

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "categories"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_products" ADD CONSTRAINT "stock_products_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_products" ADD CONSTRAINT "stock_products_stockId_fkey" FOREIGN KEY ("stockId") REFERENCES "stock"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToOption" ADD CONSTRAINT "_CategoryToOption_A_fkey" FOREIGN KEY ("A") REFERENCES "categories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToOption" ADD CONSTRAINT "_CategoryToOption_B_fkey" FOREIGN KEY ("B") REFERENCES "options"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToExtra" ADD CONSTRAINT "_CategoryToExtra_A_fkey" FOREIGN KEY ("A") REFERENCES "categories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToExtra" ADD CONSTRAINT "_CategoryToExtra_B_fkey" FOREIGN KEY ("B") REFERENCES "extras"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OrderToProduct" ADD CONSTRAINT "_OrderToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OrderToProduct" ADD CONSTRAINT "_OrderToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;
