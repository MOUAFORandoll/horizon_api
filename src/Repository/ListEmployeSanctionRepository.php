<?php

namespace App\Repository;

use App\Entity\ListEmployeSanction;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ListEmployeSanction>
 *
 * @method ListEmployeSanction|null find($id, $lockMode = null, $lockVersion = null)
 * @method ListEmployeSanction|null findOneBy(array $criteria, array $orderBy = null)
 * @method ListEmployeSanction[]    findAll()
 * @method ListEmployeSanction[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ListEmployeSanctionRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ListEmployeSanction::class);
    }

//    /**
//     * @return ListEmployeSanction[] Returns an array of ListEmployeSanction objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('l')
//            ->andWhere('l.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('l.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

//    public function findOneBySomeField($value): ?ListEmployeSanction
//    {
//        return $this->createQueryBuilder('l')
//            ->andWhere('l.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
