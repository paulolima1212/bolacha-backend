import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';

import { ProductsModule } from './products/products.module';
import { UserModule } from './user/user.module';
import { CategoryModule } from './category/category.module';
import { StockProductModule } from './stock_product/stock_product.module';
import { AuthModule } from './auth/auth.module';
import { JwtModule } from '@nestjs/jwt';
import { ExtraModule } from './extra/extra.module';
import { OptionModule } from './option/option.module';
import { CallServiceModule } from './call_service/call_service.module';
import { OrdersModule } from './orders/orders.module';
import { PrismaService } from './prisma/prisma.service';

@Module({
  imports: [
    ConfigModule.forRoot(),
    UserModule,
    CategoryModule,
    StockProductModule,
    ProductsModule,
    AuthModule,
    ExtraModule,
    OptionModule,
    CallServiceModule,
    OrdersModule,
  ],
  controllers: [],
  providers: [PrismaService],
})
export class AppModule {}
