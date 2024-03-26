<?php

namespace App\Repository;

use App\Entity\ListEmployePoste;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ListEmployePoste>
 *
 * @method ListEmployePoste|null find($id, $lockMode = null, $lockVersion = null)
 * @method ListEmployePoste|null findOneBy(array $criteria, array $orderBy = null)
 * @method ListEmployePoste[]    findAll()
 * @method ListEmployePoste[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ListEmployePosteRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ListEmployePoste::class);
    }

//    /**
//     * @return ListEmployePoste[] Returns an array of ListEmployePoste objects
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

//    public function findOneBySomeField($value): ?ListEmployePoste
//    {
//        return $this->createQueryBuilder('l')
//            ->andWhere('l.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
