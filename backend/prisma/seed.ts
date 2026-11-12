import "dotenv/config";
import { Pool } from "pg";
import { PrismaPg } from "@prisma/adapter-pg";
import { PrismaClient } from "../generated/prisma/client";

const connectionString = process.env.DATABASE_URL;
if (!connectionString) {
  throw new Error("DATABASE_URL environment variable is missing.");
}

const pool = new Pool({ connectionString });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

async function main() {
  const clinicCategory = await prisma.category.upsert({
    where: { name: "Clinics" },
    update: {},
    create: { name: "Clinics", icon: "local_hospital" },
  });

  await prisma.category.upsert({
    where: { name: "Salons" },
    update: {},
    create: { name: "Salons", icon: "content_cut" },
  });

  await prisma.category.upsert({
    where: { name: "Labs" },
    update: {},
    create: { name: "Labs", icon: "science" },
  });

  const existingBusiness = await prisma.business.findFirst({
    where: { name: "Northside Family Clinic" },
  });

  const clinic =
    existingBusiness ??
    (await prisma.business.create({
      data: {
        name: "Northside Family Clinic",
        description: "Multi-specialty clinic and dental care in Saharanpur.",
        status: "active",
        businessCategories: {
          create: { categoryId: clinicCategory.id },
        },
      },
    }));

  const existingBranch = await prisma.branch.findFirst({
    where: { businessId: clinic.id, name: "Main Branch" },
  });

  const mainBranch =
    existingBranch ??
    (await prisma.branch.create({
      data: {
        businessId: clinic.id,
        name: "Main Branch",
        address: "Sector 14, Saharanpur",
        city: "Saharanpur, UP",
        latitude: 29.968,
        longitude: 77.5552,
        phone: "+91 98765 43210",
      },
    }));

  const existingService = await prisma.service.findFirst({
    where: { businessId: clinic.id, name: "General Consultation" },
  });

  const consultation =
    existingService ??
    (await prisma.service.create({
      data: {
        businessId: clinic.id,
        name: "General Consultation",
        description: "15-minute general physician consultation.",
      },
    }));

  await prisma.branchService.upsert({
    where: {
      branchId_serviceId: {
        branchId: mainBranch.id,
        serviceId: consultation.id,
      },
    },
    update: {},
    create: {
      branchId: mainBranch.id,
      serviceId: consultation.id,
      price: 300.0,
      durationMinutes: 15,
      queueEnabled: true,
      appointmentEnabled: true,
    },
  });

  await prisma.user.upsert({
    where: { phone: "+91 98765 43210" },
    update: {},
    create: {
      fullName: "Dikshant",
      email: "dikshant@example.com",
      phone: "+91 98765 43210",
      status: "active",
    },
  });

  console.log("FlowGuard seed completed.");
}

main()
  .catch((err) => {
    console.error("Seed failed:", err);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
    await pool.end();
  });

