<?php

namespace App\Repository;

use App\Entity\Mois;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Mois>
 *
 * @method Mois|null find($id, $lockMode = null, $lockVersion = null)
 * @method Mois|null findOneBy(array $criteria, array $orderBy = null)
 * @method Mois[]    findAll()
 * @method Mois[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class MoisRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Mois::class);
    }

//    /**
//     * @return Mois[] Returns an array of Mois objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('m')
//            ->andWhere('m.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('m.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

//    public function findOneBySomeField($value): ?Mois
//    {
//        return $this->createQueryBuilder('m')
//            ->andWhere('m.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
