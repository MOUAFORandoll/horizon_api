<?php

namespace App\Entity;

use App\Repository\PaiementRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use ApiPlatform\Core\Annotation\ApiResource;
use DateTime;
use Doctrine\DBAL\Types\Types;

use Symfony\Component\Serializer\Annotation\Groups;

#[ORM\Entity(repositoryClass: PaiementRepository::class)]
#[ApiResource(
    collectionOperations: [
        'get' => [
            'normalization_context' => [
                'groups' => ['read:paiement']
            ],

        ],   'post' => []

    ]
)]
class Paiement
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups(["read:paiement"])]
    private ?int $id = null;

    #[ORM\ManyToOne(inversedBy: 'paiements')]
    #[Groups(["read:paiement"])]
    private ?UserPlateform $admin = null;

    #[ORM\ManyToOne(inversedBy: 'paiements')]
    #[Groups(["read:paiement"])]
    private ?Mois $mois = null;

    #[Groups([
        "read:paiement"
    ])]
    #[ORM\Column]
    private ?int $montant = null;

    #[Groups(["read:paiement"])]
    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $datePaiement = null;

    #[ORM\ManyToOne(inversedBy: 'paiements')]
    #[Groups(["read:paiement"])]
    private ?Employe $employe = null;

    public function __construct()
    {
        $this->datePaiement = new DateTime();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getAdmin(): ?UserPlateform
    {
        return $this->admin;
    }

    public function setAdmin(?UserPlateform $admin): static
    {
        $this->admin = $admin;

        return $this;
    }

    public function getMois(): ?Mois
    {
        return $this->mois;
    }

    public function setMois(?Mois $mois): static
    {
        $this->mois = $mois;

        return $this;
    }


    public function getMontant(): ?int
    {
        return $this->montant;
    }

    public function setMontant(int $montant): static
    {
        $this->montant = $montant;

        return $this;
    }

    public function getDatePaiement(): ?\DateTimeInterface
    {
        return $this->datePaiement;
    }

    public function setDatePaiement(\DateTimeInterface $datePaiement): static
    {
        $this->datePaiement = $datePaiement;

        return $this;
    }

    public function getEmploye(): ?Employe
    {
        return $this->employe;
    }

    public function setEmploye(?Employe $employe): static
    {
        $this->employe = $employe;

        return $this;
    }
}
