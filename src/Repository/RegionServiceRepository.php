<?php

namespace App\Repository;

use App\Entity\RegionService;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<RegionService>
 *
 * @method RegionService|null find($id, $lockMode = null, $lockVersion = null)
 * @method RegionService|null findOneBy(array $criteria, array $orderBy = null)
 * @method RegionService[]    findAll()
 * @method RegionService[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RegionServiceRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RegionService::class);
    }

//    /**
//     * @return RegionService[] Returns an array of RegionService objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('r')
//            ->andWhere('r.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('r.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

//    public function findOneBySomeField($value): ?RegionService
//    {
//        return $this->createQueryBuilder('r')
//            ->andWhere('r.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
