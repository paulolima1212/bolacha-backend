/*
  Warnings:

  - You are about to drop the column `orderId` on the `products` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "products" DROP COLUMN "orderId";

-- CreateTable
CREATE TABLE "orders_products" (
    "id" TEXT NOT NULL,
    "order_id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,

    CONSTRAINT "orders_products_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "orders_products" ADD CONSTRAINT "orders_products_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders_products" ADD CONSTRAINT "orders_products_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
