<?php

namespace App\Controller;

use App\Entity\Mois;
use App\Repository\MoisRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Doctrine\ORM\EntityManagerInterface;

class MoisApiController extends AbstractController
{
    private $em;
    private $myFunction;
    public function __construct(

        EntityManagerInterface $em,



    ) {
        $this->em = $em;
    }
    #[Route('/init-mois', name: 'api_mois_index', methods: ['GET'])]
    public function index(MoisRepository $moisRepository, SerializerInterface $serializer): JsonResponse
    {

        $libellesMois = [
            'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
            'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
        ];

        foreach ($libellesMois as $libelle) {
            $mois = new Mois(); // Créez une nouvelle instance de votre entité Mois
            $mois->setLibelle($libelle); // Utilisez le setter approprié pour définir le libellé

            $this->em->persist($mois); // Prépare l'entité à être sauvegardée dans la base de données
        }

        $this->em->flush(); // Exécute les requêtes SQL pour sauvegarder les entités
        return new JsonResponse(['message' => 'ok'], Response::HTTP_OK, [], true);
    }
    #[Route('/init-mois-sec', name: 'api_mois_index_sec', methods: ['GET'])]
    public function index_sec(MoisRepository $moisRepository, SerializerInterface $serializer): JsonResponse
    {
        $i = 1;

        $libellesMois = $this->em->getRepository(Mois::class)->findAll();

        foreach ($libellesMois as $mois) {
            $mois->setNumSigle($i);
            $i++;
            $this->em->persist($mois);
        }

        $this->em->flush();
        return new JsonResponse(['message' => 'ok'], Response::HTTP_OK, [], true);
    }
}
