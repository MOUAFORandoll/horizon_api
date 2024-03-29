<?php

namespace App\Controller;

use App\Entity\Absences;
use App\Entity\Employe;
use App\Entity\ListEmployeSanction;
use App\Entity\Mois;
use App\Repository\EmployeRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\ORM\EntityManagerInterface;
use
    Symfony\Component\Serializer\SerializerInterface;

#[Route('/employes')]
class EmployeController extends AbstractController
{


    private $em;
    public function __construct(

        EntityManagerInterface $em,

    ) {
        $this->em = $em;
    }
    #[Route('/{id}', name: 'employes_delete', methods: ['POST'])]
    public function delete(Request $request, Employe $employe): Response
    {
        // if ($this->isCsrfTokenValid('delete' . $employe->getId(), $request->request->get('_token'))) {
        //     $entityManager = $this->getDoctrine()->getManager();
        //     $entityManager->remove($employe);
        //     $entityManager->flush();
        // }

        return $this->redirectToRoute('api_employes_index');
    }
    #[Route('/', name: 'employe_index', methods: ['GET'])]
    public function employeIndex(EmployeRepository $employeRepository, SerializerInterface $serializer): JsonResponse
    {
        $employeAll = $employeRepository->findAll();

        return new JsonResponse(['data' =>       array_map(function (Employe $employe) {
            $salaire = $this->calCulSalaire($employe);
            return  [
                'id' => $employe->getId(),
                'nom' => $employe->getNom(),
                'prenom' => $employe->getPrenom(),
                'salaire' => $salaire,
            ];
        }, $employeAll)], 200);
    }
    function calCulSalaire(Employe $employe): int
    {

        $mois = $this->em->getRepository(Mois::class)->find(2);
        // recuperer mois actuelle
        $salaireInitial = $employe->getSalaire();
        $sanction = 0;
        $sanctionList = $this->em->getRepository(ListEmployeSanction::class)->findBy(['employe' => $employe, 'mois' =>   $mois]);
        foreach ($sanctionList as  $value) {
            $sanction +=
                $value->getSanction()->getMontant();
        }
        $absence = 0;
        $absenceList = $this->em->getRepository(Absences::class)->findBy(['employe' => $employe, 'mois' =>   $mois]);
        foreach ($absenceList as  $value) {
            $absence +=
                1000;
        }
        $salaireFinal =
            $salaireInitial    - $sanction - $absence;

        return
            $salaireFinal;
    }
}
