<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Doctrine\ORM\EntityManagerInterface;
use App\Entity\Medicament;
use App\Entity\TypePoste;
use App\Entity\TypeUser;
use App\Entity\UserPlateform;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;
use App\FunctionU\MyFunction;
use App\Repository\PosteRepository;
use App\Repository\TypePosteRepository;
use DateInterval;
use DateTime;
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

        // $newAdmin = new UserPlateform();
        // $newAdmin
        //     ->setNom('Admin');
        // $newAdmin
        //     ->setPrenom('Admin');
        // $newAdmin
        //     ->setPhone('690863838');
        // $passwordN = $this->passwordEncoder->hashPassword(
        //     $newAdmin,
        //     '0000'
        // );
        // $newAdmin
        //     ->setPassword($passwordN);


        // $this->em->persist($newAdmin);
        // $this->em->flush();

        $newAdmin = new UserPlateform();
        $newAdmin
            ->setNom('EBALE');
        $newAdmin
            ->setPrenom('GREGORE');
        $newAdmin
            ->setPhone('657530815');
        $passwordN = $this->passwordEncoder->hashPassword(
            $newAdmin,
            'Hérardgregore'
        );
        $newAdmin
            ->setPassword($passwordN);


        $this->em->persist($newAdmin);
        $newAdmin1 = new UserPlateform();

        $newAdmin1
            ->setNom('EBALE EBALE');
        $newAdmin1
            ->setPrenom('ARNOLD');
        $newAdmin1
            ->setPhone('696979083');
        $passwordN1 = $this->passwordEncoder->hashPassword(
            $newAdmin1,
            'LeGrand89'
        );
        $newAdmin1
            ->setPassword($passwordN1);


        $this->em->persist($newAdmin);
        $this->em->persist($newAdmin1);
        $this->em->flush();

        return new JsonResponse([
            'message' => 'Success',
        ], 200);
    }
    #[Route('/test', name: 'test', methods: ['GET'])]
    public function test(Request $request)
    {



        // Créer un objet DateTime pour la date actuelle
        $now = new DateTime();

        // Afficher le mois en cours
        echo "Mois en cours : " . $now->format('m') . "\n"; // 'm' formate le mois avec des zéros initiaux, 'n' sans zéros initiaux

        $now->sub(new DateInterval('P1M')); // 'P1M' signifie une période de 1 mois

        // Afficher le mois précédent
        echo "Mois précédent : " . $now->format('m') . "\n";
        return new JsonResponse([
            'a'
            => "Mois en cours : " . $now->format('m') . "\n",
            'b' => "Mois précédent : " . $now->format('m') . "\n",
        ], 200);
    }
    #[Route('/init-type-poste', name: 'api_type_poste', methods: ['GET'])]
    public function api_type_poste(TypePosteRepository  $tp, SerializerInterface $serializer): JsonResponse
    {

        $lbposte = [
            'Jour', 'Nuit'
        ];

        foreach ($lbposte as $tpposte) {
            $tp = new TypePoste(); // Créez une nouvelle instance de votre entité Mois
            $tp->setLibelle($tpposte); // Utilisez le setter approprié pour définir le libellé

            $this->em->persist($tp); // Prépare l'entité à être sauvegardée dans la base de données
        }

        $this->em->flush();
        return new JsonResponse(['message' => 'ok'], 200);
    }
}
