<?php

namespace App\Entity;

use App\Repository\EmployeRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use ApiPlatform\Core\Annotation\ApiResource;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;

#[ORM\Entity(repositoryClass: EmployeRepository::class)]
#[ApiResource(collectionOperations: [
    'get' => [
        'normalization_context' => [
            'groups' => ['read:employe']
        ],

    ],
    'post' => [
        'denormalization_context' => [
            'groups' => ['create:employe']
        ],

    ]
])]
class Employe
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups("read:employe")]
    private ?int $id = null;

    #[ORM\ManyToOne(inversedBy: 'employes')]
    #[Groups(["read:employe", "create:employe"])]
    private ?UserPlateform $admin = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    #[Groups(["read:employe", "create:employe"])]
    private ?\DateTimeInterface $datePriseFonction = null;

    #[ORM\ManyToOne(inversedBy: 'employes')]
    #[Groups(["read:employe", "create:employe", "read:paiement"])]
    private ?RegionService $regionDeService = null;

    #[ORM\OneToMany(mappedBy: 'employe', targetEntity: Absences::class)]
    #[Groups(["read:employe"])]
    private Collection $absences;


    #[ORM\Column]
    #[Groups(["read:employe", "create:employe", "read:paiement"])]
    private ?int $salaire = null;

    #[ORM\Column(length: 255)]
    #[Groups(["read:sanction-employe", "read:employe", "create:employe", "read:paiement", 'read:poste-employe'])]
    private ?string $nom = null;

    #[ORM\Column(length: 255)]
    #[Groups(["read:employe", "create:employe", "read:paiement"])]
    private ?string $prenom = null;

    #[ORM\Column(length: 255)]
    #[Groups(["read:sanction-employe", "read:employe", "create:employe", "read:paiement", 'read:poste-employe'])]
    private ?string $phone = null;

    #[ORM\Column(length: 255, nullable: true)]
    #[Groups(["read:employe", "read:paiement"])]
    private ?string $matricule = null;

    #[ORM\OneToMany(mappedBy: 'employe', targetEntity: Paiement::class)]
    private Collection $paiements;


    #[ORM\Column(type: Types::DATETIME_MUTABLE, nullable: true)]
    #[Groups(["read:employe", "read:paiement"])]
    private $dateCreated;

    #[ORM\OneToMany(mappedBy: 'employe', targetEntity: ListEmployePoste::class)]
    private Collection $listEmployePostes;

    #[ORM\OneToMany(mappedBy: 'employe', targetEntity: ListEmployeSanction::class)]
    private Collection $listEmployeSanctions;
    public function __construct()
    {
        $this->dateCreated = new \DateTime();
        $this->absences = new ArrayCollection();
        $this->matricule = '000';
        $this->paiements = new ArrayCollection();
        $this->listEmployePostes = new ArrayCollection();
        $this->listEmployeSanctions = new ArrayCollection();
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

    public function getDatePriseFonction(): ?\DateTimeInterface
    {
        return $this->datePriseFonction;
    }

    public function setDatePriseFonction(\DateTimeInterface $datePriseFonction): static
    {
        $this->datePriseFonction = $datePriseFonction;

        return $this;
    }

    public function getRegionDeService(): ?RegionService
    {
        return $this->regionDeService;
    }

    public function setRegionDeService(?RegionService $regionDeService): static
    {
        $this->regionDeService = $regionDeService;

        return $this;
    }

    public function getDateCreated(): ?\DateTimeInterface
    {
        return $this->dateCreated;
    }

    public function setDateCreated(\DateTimeInterface $dateCreated): self
    {
        $this->dateCreated = $dateCreated;

        return $this;
    }

    /**
     * @return Collection<int, Absences>
     */
    public function getAbsences(): Collection
    {
        return $this->absences;
    }

    public function addAbsence(Absences $absence): static
    {
        if (!$this->absences->contains($absence)) {
            $this->absences->add($absence);
            $absence->setEmploye($this);
        }

        return $this;
    }

    public function removeAbsence(Absences $absence): static
    {
        if ($this->absences->removeElement($absence)) {
            // set the owning side to null (unless already changed)
            if ($absence->getEmploye() === $this) {
                $absence->setEmploye(null);
            }
        }

        return $this;
    }

    public function getSalaire(): ?int
    {
        return $this->salaire;
    }

    public function setSalaire(int $salaire): static
    {
        $this->salaire = $salaire;

        return $this;
    }

    public function getNom(): ?string
    {
        return $this->nom;
    }

    public function setNom(string $nom): static
    {
        $this->nom = $nom;

        return $this;
    }

    public function getPrenom(): ?string
    {
        return $this->prenom;
    }

    public function setPrenom(string $prenom): static
    {
        $this->prenom = $prenom;

        return $this;
    }

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(string $phone): static
    {
        $this->phone = $phone;

        return $this;
    }

    public function getMatricule(): ?string
    {
        return $this->matricule;
    }

    public function setMatricule(string $matricule): static
    {
        $this->matricule = $matricule;

        return $this;
    }

    /**
     * @return Collection<int, Paiement>
     */
    public function getPaiements(): Collection
    {
        return $this->paiements;
    }

    public function addPaiement(Paiement $paiement): static
    {
        if (!$this->paiements->contains($paiement)) {
            $this->paiements->add($paiement);
            $paiement->setEmploye($this);
        }

        return $this;
    }

    public function removePaiement(Paiement $paiement): static
    {
        if ($this->paiements->removeElement($paiement)) {
            // set the owning side to null (unless already changed)
            if ($paiement->getEmploye() === $this) {
                $paiement->setEmploye(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, ListEmployePoste>
     */
    public function getListEmployePostes(): Collection
    {
        return $this->listEmployePostes;
    }

    public function addListEmployePoste(ListEmployePoste $listEmployePoste): static
    {
        if (!$this->listEmployePostes->contains($listEmployePoste)) {
            $this->listEmployePostes->add($listEmployePoste);
            $listEmployePoste->setEmploye($this);
        }

        return $this;
    }

    public function removeListEmployePoste(ListEmployePoste $listEmployePoste): static
    {
        if ($this->listEmployePostes->removeElement($listEmployePoste)) {
            // set the owning side to null (unless already changed)
            if ($listEmployePoste->getEmploye() === $this) {
                $listEmployePoste->setEmploye(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, ListEmployeSanction>
     */
    public function getListEmployeSanctions(): Collection
    {
        return $this->listEmployeSanctions;
    }

    public function addListEmployeSanction(ListEmployeSanction $listEmployeSanction): static
    {
        if (!$this->listEmployeSanctions->contains($listEmployeSanction)) {
            $this->listEmployeSanctions->add($listEmployeSanction);
            $listEmployeSanction->setEmploye($this);
        }

        return $this;
    }

    public function removeListEmployeSanction(ListEmployeSanction $listEmployeSanction): static
    {
        if ($this->listEmployeSanctions->removeElement($listEmployeSanction)) {
            // set the owning side to null (unless already changed)
            if ($listEmployeSanction->getEmploye() === $this) {
                $listEmployeSanction->setEmploye(null);
            }
        }

        return $this;
    }
}
