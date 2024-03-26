<?php

namespace App\Entity;

use App\Repository\ListEmployeSanctionRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

use Symfony\Component\Serializer\Annotation\Groups;
use ApiPlatform\Core\Annotation\ApiResource;

#[ORM\Entity(repositoryClass: ListEmployeSanctionRepository::class)] #[ApiResource(
    collectionOperations: [
        'get' => [
            'normalization_context' => [
                'groups' => ['read:sanction-employe']
            ],

        ],
        'post' => [
            'denormalization_context' => [
                'groups' => ['create:sanction-employe']
            ],

        ]

    ]
)]
class ListEmployeSanction
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups([
        "read:sanction-employe"
    ])]  private ?int $id = null;

    #[ORM\ManyToOne(inversedBy: 'listEmployeSanctions')]
    #[Groups([
        "read:sanction-employe", "create:sanction-employe"
    ])]    private ?Employe $employe = null;

    #[ORM\ManyToOne(inversedBy: 'listEmployeSanctions')]
    #[Groups([
        "read:sanction-employe", "create:sanction-employe"
    ])]   private ?Sanction $sanction = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $dateCreated = null;
    public function __construct()
    {
        $this->dateCreated = new \DateTime();
    }
    public function getId(): ?int
    {
        return $this->id;
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

    public function getSanction(): ?Sanction
    {
        return $this->sanction;
    }

    public function setSanction(?Sanction $sanction): static
    {
        $this->sanction = $sanction;

        return $this;
    }

    public function getDateCreated(): ?\DateTimeInterface
    {
        return $this->dateCreated;
    }

    public function setDateCreated(\DateTimeInterface $dateCreated): static
    {
        $this->dateCreated = $dateCreated;

        return $this;
    }
}
