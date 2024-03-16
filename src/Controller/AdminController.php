<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Doctrine\ORM\EntityManagerInterface;
use App\Entity\Medicament;
use App\Entity\TypeUser;
use App\Entity\UserPlateform;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;
use App\FunctionU\MyFunction;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class AdminController extends AbstractController
{
    private $em;
    private   $serializer;
    private $clientWeb;
    private $paginator;
    private $passwordEncoder;

    private $myFunction;
    public function __construct(

        EntityManagerInterface $em,
        HttpClientInterface $clientWeb,
        MyFunction
        $myFunction,
        UserPasswordHasherInterface    $passwordEncoder,


    ) {
        $this->em = $em;
        $this->passwordEncoder = $passwordEncoder;

        $this->myFunction = $myFunction;

        $this->clientWeb = $clientWeb;
    }
    #[Route('/create-admin', name: 'Admin', methods: ['GET'])]
    public function Admin(Request $request)
    {

        $newAdmin = new UserPlateform();
        $newAdmin
            ->setNom('Admin');
        $newAdmin
            ->setPrenom('Admin');
        $newAdmin
            ->setPhone('690863838');
        $passwordN = $this->passwordEncoder->hashPassword(
            $newAdmin,
            '0000'
        );
        $newAdmin
            ->setPassword($passwordN);


        $this->em->persist($newAdmin);
        $this->em->flush();

        return new JsonResponse([
            'message' => 'Success',
        ], 200);
    }
}
