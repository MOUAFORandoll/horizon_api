<?php

namespace App\Controller;

use App\Entity\Employe;
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
}
