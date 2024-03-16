<?php

namespace App\FunctionU;

use App\Entity\ColisObject;
use App\Entity\ControlMission;
use App\Entity\ListMissionBiker;
use App\Entity\Livraison;
use App\Entity\LivraisonKey;
use App\Entity\LivraisonOrdonnanceKey;
use App\Entity\Medicament;
use App\Entity\Mission;
use App\Entity\MissionSession;
use App\Entity\ObjectFile;
use App\Entity\Ordonnance;
use App\Entity\Pharmacie;
use App\Entity\Secteur;
use App\Entity\UserObject;
use App\Entity\UserPlateform;
use Doctrine\ORM\EntityManagerInterface;
use Dompdf\Dompdf;
use Exception;
use Symfony\Component\Mailer\MailerInterface;
use Swift_Mailer;
use Swift_SmtpTransport;
use Symfony\Component\HttpFoundation\File\File as FileFile;
use Symfony\Component\Mailer\Mailer;
use Symfony\Component\Mailer\Transport;
use Symfony\Component\Mime\Email;
use Symfony\Contracts\HttpClient\HttpClientInterface;
use Stripe\Stripe;
use Stripe\Charge;
use Stripe\Token;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Mailer\Exception\TransportExceptionInterface;

class MyFunction
{
    public $emetteur = 'admin@prikado.com';
    public $host_serveur_socket;

    private $mailer;
    private $em;
    private $client;
    private
        $token    = "pk.tfLODRBooIKOCisurizG7NZNNYCO6wcGry0PranjBocWGKLNKFET3OYnGbR01WF0ftNrooMC5Z9iH8GfQv2llWNkkFCy0zk2wGkHdl6RD4LmTc3bBg3iauC7FdFTK";

    const
        BACK_END_URL =
        'https://api.horizon.cm';

    // BACK_END_URL =
    // 'http://192.168.43.134:8000';
    // BACK_END_URL =
    // 'http://192.168.1.102:8000';
    const
        PAGINATION = 14;
    public function __construct(
        EntityManagerInterface $em,
        HttpClientInterface $client,
        MailerInterface $mailer,


    ) {

        $this->host_serveur_socket
            =/*  $_SERVER['REQUEST_SCHEME'] . ://.  $_SERVER['SERVER_ADDR'] */
            // 'http://192.168.1.102'
            'http://192.168.43.134'
            . ':3000';
        $this->client =
            $client;
        $this->mailer =
            $mailer;
        $this->em = $em;
    }
}
