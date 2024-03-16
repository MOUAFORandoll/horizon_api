<?php

namespace App\Controller;

use App\Entity\Absences;
use App\Repository\AbsencesRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

#[Route('/absences')]
class AbsencesController extends AbstractController
{
    private $em;
    public function __construct(

        EntityManagerInterface $em,

    ) {
        $this->em = $em;
    }
    #[Route('/', name: 'api_absences_index', methods: ['GET'])]
    public function index(AbsencesRepository $absencesRepository, SerializerInterface $serializer): JsonResponse
    {
        $absences = $absencesRepository->findAll();
        $json = $serializer->serialize($absences, 'json', ['groups' => 'absence:read']);
        return new JsonResponse($json, Response::HTTP_OK, [], true);
    }

    #[Route('/new', name: 'api_absences_new', methods: ['POST'])]
    public function new(Request $request, EntityManagerInterface $entityManager, SerializerInterface $serializer): JsonResponse
    {
        $absence = $serializer->deserialize($request->getContent(), Absences::class, 'json');
        $entityManager->persist($absence);
        $entityManager->flush();
        return new JsonResponse(null, Response::HTTP_CREATED);
    }

    #[Route('/{id}', name: 'api_absences_show', methods: ['GET'])]
    public function show(Absences $absence, SerializerInterface $serializer): JsonResponse
    {
        $json = $serializer->serialize($absence, 'json', ['groups' => 'absence:read']);
        return new JsonResponse($json, Response::HTTP_OK, [], true);
    }

    #[Route('/{id}', name: 'absences_delete', methods: ['POST'])]
    public function delete(Request $request, Absences $absence): Response
    {
        if ($this->isCsrfTokenValid('delete' . $absence->getId(), $request->request->get('_token'))) {
            $entityManager = $this->em;
            $entityManager->remove($absence);
            $entityManager->flush();
        }

        return $this->redirectToRoute('absences_index');
    }
}
