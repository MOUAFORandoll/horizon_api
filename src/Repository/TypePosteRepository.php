<?php

namespace App\Repository;

use App\Entity\TypePoste;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<TypePoste>
 *
 * @method TypePoste|null find($id, $lockMode = null, $lockVersion = null)
 * @method TypePoste|null findOneBy(array $criteria, array $orderBy = null)
 * @method TypePoste[]    findAll()
 * @method TypePoste[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class TypePosteRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, TypePoste::class);
    }

//    /**
//     * @return TypePoste[] Returns an array of TypePoste objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('t')
//            ->andWhere('t.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('t.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

//    public function findOneBySomeField($value): ?TypePoste
//    {
//        return $this->createQueryBuilder('t')
//            ->andWhere('t.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
