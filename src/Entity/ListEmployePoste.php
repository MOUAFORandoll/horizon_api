<?php

namespace App\Entity;

use App\Repository\ListEmployePosteRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;
use ApiPlatform\Core\Annotation\ApiResource;
use ApiPlatform\Core\Annotation\ApiFilter;
use ApiPlatform\Core\Bridge\Doctrine\Orm\Filter\SearchFilter;

#[ORM\Entity(repositoryClass: ListEmployePosteRepository::class)]
#[ApiResource(
    collectionOperations: [
        'get' => [
            'normalization_context' => [
                'groups' => ['read:poste-employe']
            ],

        ],
        'post' => [
            'denormalization_context' => [
                'groups' => ['create:poste-employe']
            ],

        ]

    ]
)] #[ApiFilter(SearchFilter::class, properties: ['employe' => 'exact'])]
class ListEmployePoste
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[Groups([
        "read:poste-employe"
    ])]
    #[ORM\Column]
    private ?int $id = null;
    #[Groups([
        "read:poste-employe", "create:poste-employe"
    ])]
    #[ORM\ManyToOne(inversedBy: 'listEmployePostes')]
    private ?Employe $employe = null;
    #[Groups([
        "read:poste-employe", "create:poste-employe"
    ])]
    #[ORM\ManyToOne(inversedBy: 'listEmployePostes')]
    private ?Poste $poste = null;

    #[Groups([
        "read:poste-employe"
    ])]
    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $dateCreated = null;

    #[ORM\ManyToOne(inversedBy: 'listEmployePostes')]
    #[Groups([
        "read:poste-employe", "create:poste-employe"
    ])]
    private ?TypePoste $typePoste = null;
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

    public function getPoste(): ?Poste
    {
        return $this->poste;
    }

    public function setPoste(?Poste $poste): static
    {
        $this->poste = $poste;

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

    public function getTypePoste(): ?TypePoste
    {
        return $this->typePoste;
    }

    public function setTypePoste(?TypePoste $typePoste): static
    {
        $this->typePoste = $typePoste;

        return $this;
    }
}
