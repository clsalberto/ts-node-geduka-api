-- CreateTable
CREATE TABLE "locations" (
    "id" UUID NOT NULL,
    "zip_code" CHAR(9) NOT NULL,
    "place" VARCHAR NOT NULL,
    "district" VARCHAR NOT NULL,
    "city" VARCHAR NOT NULL,
    "state" CHAR(2) NOT NULL,
    "country" CHAR(3) NOT NULL,

    CONSTRAINT "locations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "addresses" (
    "id" UUID NOT NULL,
    "location_id" UUID NOT NULL,
    "number" VARCHAR(8) NOT NULL,
    "complement" VARCHAR(60),
    "reference_point" VARCHAR,
    "lng" REAL,
    "lat" REAL,

    CONSTRAINT "addresses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tenants" (
    "id" UUID NOT NULL,
    "address_id" UUID NOT NULL,
    "fantasy_name" VARCHAR NOT NULL,
    "company_name" VARCHAR NOT NULL,
    "cnpj" CHAR(18) NOT NULL,
    "phone" CHAR(16) NOT NULL,
    "email" VARCHAR NOT NULL,
    "domain" VARCHAR(60) NOT NULL,
    "created_at" TIMESTAMP NOT NULL,

    CONSTRAINT "tenants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" UUID NOT NULL,
    "tenant_id" UUID NOT NULL,
    "name" VARCHAR NOT NULL,
    "email" VARCHAR NOT NULL,
    "password" TEXT NOT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "active" BOOLEAN NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tokens" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "hash" TEXT NOT NULL,
    "expired_at" TIMESTAMP NOT NULL,

    CONSTRAINT "tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" UUID NOT NULL,
    "name" VARCHAR(60) NOT NULL,
    "description" TEXT,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permissios" (
    "id" UUID NOT NULL,
    "name" VARCHAR(120) NOT NULL,
    "description" TEXT,

    CONSTRAINT "permissios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_roles_users" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_permissions_roles" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_permissions_users" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateIndex
CREATE INDEX "locations_zip_code_state_idx" ON "locations"("zip_code", "state");

-- CreateIndex
CREATE INDEX "addresses_location_id_idx" ON "addresses"("location_id");

-- CreateIndex
CREATE INDEX "tenants_address_id_cnpj_email_domain_idx" ON "tenants"("address_id", "cnpj", "email", "domain");

-- CreateIndex
CREATE INDEX "users_tenant_id_email_idx" ON "users"("tenant_id", "email");

-- CreateIndex
CREATE INDEX "tokens_user_id_hash_idx" ON "tokens"("user_id", "hash");

-- CreateIndex
CREATE UNIQUE INDEX "roles_name_key" ON "roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "permissios_name_key" ON "permissios"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_roles_users_AB_unique" ON "_roles_users"("A", "B");

-- CreateIndex
CREATE INDEX "_roles_users_B_index" ON "_roles_users"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_permissions_roles_AB_unique" ON "_permissions_roles"("A", "B");

-- CreateIndex
CREATE INDEX "_permissions_roles_B_index" ON "_permissions_roles"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_permissions_users_AB_unique" ON "_permissions_users"("A", "B");

-- CreateIndex
CREATE INDEX "_permissions_users_B_index" ON "_permissions_users"("B");

-- AddForeignKey
ALTER TABLE "addresses" ADD CONSTRAINT "addresses_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "locations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tenants" ADD CONSTRAINT "tenants_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "addresses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_tenant_id_fkey" FOREIGN KEY ("tenant_id") REFERENCES "tenants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tokens" ADD CONSTRAINT "tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_roles_users" ADD CONSTRAINT "_roles_users_A_fkey" FOREIGN KEY ("A") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_roles_users" ADD CONSTRAINT "_roles_users_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_permissions_roles" ADD CONSTRAINT "_permissions_roles_A_fkey" FOREIGN KEY ("A") REFERENCES "permissios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_permissions_roles" ADD CONSTRAINT "_permissions_roles_B_fkey" FOREIGN KEY ("B") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_permissions_users" ADD CONSTRAINT "_permissions_users_A_fkey" FOREIGN KEY ("A") REFERENCES "permissios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_permissions_users" ADD CONSTRAINT "_permissions_users_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
