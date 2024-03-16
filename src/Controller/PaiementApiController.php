<?php

namespace App\Controller;

use App\Entity\Paiement;
use App\Repository\PaiementRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Doctrine\ORM\EntityManagerInterface;
use
    Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

#[Route('/paiements')]
class PaiementApiController extends AbstractController
{
    private $em;
    public function __construct(

        EntityManagerInterface $em,

    ) {
        $this->em = $em;
    }
    #[Route('/', name: 'api_paiements_index', methods: ['GET'])]
    public function index(PaiementRepository $paiementRepository, SerializerInterface $serializer): JsonResponse
    {
        $paiements = $paiementRepository->findAll();
        $json = $serializer->serialize($paiements, 'json', ['groups' => 'paiement:read']);
        return new JsonResponse($json, Response::HTTP_OK, [], true);
    }

    #[Route('/new', name: 'api_paiements_new', methods: ['POST'])]
    public function new(Request $request, EntityManagerInterface $entityManager, SerializerInterface $serializer): JsonResponse
    {
        $paiement = $serializer->deserialize($request->getContent(), Paiement::class, 'json');
        $entityManager->persist($paiement);
        $entityManager->flush();
        return new JsonResponse(null, Response::HTTP_CREATED);
    }

    #[Route('/{id}', name: 'api_paiements_show', methods: ['GET'])]
    public function show(Paiement $paiement, SerializerInterface $serializer): JsonResponse
    {
        $json = $serializer->serialize($paiement, 'json', ['groups' => 'paiement:read']);
        return new JsonResponse($json, Response::HTTP_OK, [], true);
    }

    #[Route('/{id}', name: 'paiements_delete', methods: ['POST'])]
    public function delete(Request $request, Paiement $paiement): Response
    {
        if ($this->isCsrfTokenValid('delete' . $paiement->getId(), $request->request->get('_token'))) {
            $entityManager = $this->em;
            $entityManager->remove($paiement);
            $entityManager->flush();
        }

        return $this->redirectToRoute('api_paiements_index');
    }
}
